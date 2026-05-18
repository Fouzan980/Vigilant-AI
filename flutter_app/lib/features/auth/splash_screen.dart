import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../shared/services/auth_service.dart';
import '../../shared/models/enums.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  void _checkAuth() async {
    await Future.delayed(
      const Duration(seconds: 2),
    ); // Show splash for 2 seconds
    if (!mounted) return;

    final user = ref.read(authStateProvider);
    if (user == null) {
      context.go('/login');
    } else {
      switch (user.role) {
        case UserRole.citizen:
          context.go('/citizen');
          break;
        case UserRole.admin:
          context.go('/admin');
          break;
        case UserRole.lawEnforcement:
          context.go('/law');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shield_moon_rounded,
              size: 120,
              color: Colors.white,
            ),
            const SizedBox(height: 24),
            Text(
              'Vigilant',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Loading secure environment...',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
