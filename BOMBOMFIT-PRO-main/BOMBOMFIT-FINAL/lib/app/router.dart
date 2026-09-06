import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/auth_gate.dart';
import '../features/auth/presentation/login_page.dart';
import '../features/auth/presentation/signup_page.dart';
import '../features/home/presentation/home_page.dart';
import '../features/onboarding/presentation/onboarding_page.dart';
import '../features/water/presentation/water_page.dart';
import '../features/workouts/presentation/workouts_page.dart';
import '../features/nutrition/presentation/nutrition_page.dart';
import '../features/steps/presentation/steps_page.dart';
import '../features/progress/presentation/progress_page.dart';
import '../features/ai/presentation/ai_page.dart';
import '../features/profile/presentation/profile_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/gate',
    routes: [
      GoRoute(path: '/gate', builder: (_, __) => const AuthGate()),
      GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
      GoRoute(path: '/signup', builder: (_, __) => const SignupPage()),
      GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingPage()),
      GoRoute(path: '/home', builder: (_, __) => const HomePage()),
      GoRoute(path: '/water', builder: (_, __) => const WaterPage()),
      GoRoute(path: '/workouts', builder: (_, __) => const WorkoutsPage()),
      GoRoute(path: '/nutrition', builder: (_, __) => const NutritionPage()),
      GoRoute(path: '/steps', builder: (_, __) => const StepsPage()),
      GoRoute(path: '/progress', builder: (_, __) => const ProgressPage()),
      GoRoute(path: '/ai', builder: (_, __) => const AiPage()),
      GoRoute(path: '/profile', builder: (_, __) => const ProfilePage()),
    ],
  );
});
