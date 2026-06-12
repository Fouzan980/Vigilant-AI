import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

import '../models/user.dart';
import '../models/enums.dart';
import '../../config/env_config.dart';

final authServiceProvider = Provider((ref) => AuthService());
final authStateProvider = StateProvider<User?>((ref) => null);
final firebaseUserProvider = StateProvider<firebase_auth.User?>((ref) => null);

class AuthService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  late final Dio _dio;
  bool _googleInitialized = false;

  AuthService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: EnvConfig.apiBaseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }

  /// Stream to listen to auth state changes
  Stream<firebase_auth.User?> get authStateChanges => _auth.authStateChanges();

  /// Sign in with Email and Password
  Future<User?> login(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _mapFirebaseUserToAppUser(credential.user);
    } catch (e) {
      debugPrint('Email Login Error: $e');
      rethrow;
    }
  }

  /// Register with Email and Password
  Future<User?> register(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Sync new user to backend (non-blocking)
      try {
        await _dio.post(
          '/users/register',
          data: {
            'id': credential.user?.uid,
            'email': email,
            'name': credential.user?.displayName ?? email.split('@').first,
            'role': 'citizen',
          },
        );
      } catch (syncError) {
        debugPrint('Backend user sync failed (non-fatal): $syncError');
      }

      return _mapFirebaseUserToAppUser(credential.user);
    } catch (e) {
      debugPrint('Email Register Error: $e');
      rethrow;
    }
  }

  /// Sign in with Google — platform-aware
  Future<User?> signInWithGoogle() async {
    try {
      firebase_auth.UserCredential userCredential;

      if (kIsWeb) {
        // On web, use Firebase's signInWithPopup — no GoogleSignIn needed.
        // authenticate() is unsupported on web and will throw UnimplementedError.
        final googleProvider = firebase_auth.GoogleAuthProvider()
          ..addScope('email')
          ..addScope('profile');
        userCredential = await _auth.signInWithPopup(googleProvider);
      } else {
        // On Android/iOS, use the GoogleSignIn package flow.
        if (!_googleInitialized) {
          await _googleSignIn.initialize();
          _googleInitialized = true;
        }

        final account = await _googleSignIn.authenticate();
        final idToken = account.authentication.idToken;

        String? accessToken;
        try {
          final authz = await account.authorizationClient
              .authorizationForScopes([]);
          accessToken = authz?.accessToken;
        } catch (e) {
          debugPrint('Authorization for access token failed (non-fatal): $e');
        }

        final credential = firebase_auth.GoogleAuthProvider.credential(
          idToken: idToken,
          accessToken: accessToken,
        );
        userCredential = await _auth.signInWithCredential(credential);
      }

      try {
        await _dio.post(
          '/users/register',
          data: {
            'id': userCredential.user?.uid,
            'email': userCredential.user?.email,
            'name': userCredential.user?.displayName ?? 'Google User',
            'role': 'citizen',
            'phone': userCredential.user?.phoneNumber ?? '',
          },
        );
      } catch (syncError) {
        debugPrint('Backend Google user sync failed (non-fatal): $syncError');
      }

      return _mapFirebaseUserToAppUser(userCredential.user);
    } on GoogleSignInException catch (e) {
      debugPrint('Google Sign-In cancelled or failed: ${e.code}');
      return null;
    } catch (e) {
      debugPrint('Google Sign-In Error: $e');
      rethrow;
    }
  }

  /// Helper to map Firebase User to local User model
  User? _mapFirebaseUserToAppUser(firebase_auth.User? firebaseUser) {
    if (firebaseUser == null) return null;

    UserRole role = UserRole.citizen;
    if (firebaseUser.email?.contains('admin') == true) role = UserRole.admin;
    if (firebaseUser.email?.contains('police') == true) {
      role = UserRole.lawEnforcement;
    }

    return User()
      ..id = firebaseUser.uid
      ..name = firebaseUser.displayName ?? 'Unknown User'
      ..email = firebaseUser.email ?? ''
      ..role = role
      ..district = 'Unassigned'
      ..phone = firebaseUser.phoneNumber ?? ''
      ..reportsCount = 0
      ..joinDate = firebaseUser.metadata.creationTime ?? DateTime.now()
      ..isActive = true;
  }

  /// Logout
  Future<void> logout(WidgetRef ref) async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    ref.read(authStateProvider.notifier).state = null;
    ref.read(firebaseUserProvider.notifier).state = null;
  }
}
