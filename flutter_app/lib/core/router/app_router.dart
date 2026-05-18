import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../features/auth/splash_screen.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/citizen/citizen_main_screen.dart';
import '../../features/citizen/sos/sos_screen.dart';
import '../../features/citizen/shadow_score/shadow_score_screen.dart';
import '../../features/admin/admin_main_screen.dart';
import '../../features/law_enforcement/law_main_screen.dart';

// Placeholder screens for router
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(child: Text(title)),
  );
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/citizen',
      builder: (context, state) => const CitizenMainScreen(),
    ),
    GoRoute(
      path: '/citizen/sos',
      builder: (context, state) => const SOSScreen(),
    ),
    GoRoute(
      path: '/citizen/score',
      builder: (context, state) => const ShadowScoreScreen(),
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminMainScreen(),
    ),
    GoRoute(path: '/law', builder: (context, state) => const LawMainScreen()),
  ],
);
