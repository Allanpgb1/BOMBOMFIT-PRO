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
      GoRoute(path: '/gate', builder: (_, _) => const AuthGate()),
      GoRoute(path: '/login', builder: (_, _) => const LoginPage()),
      GoRoute(path: '/signup', builder: (_, _) => const SignupPage()),
      GoRoute(path: '/onboarding', builder: (_, _) => const OnboardingPage()),
      GoRoute(path: '/home', builder: (_, _) => const HomePage()),
      GoRoute(path: '/water', builder: (_, _) => const WaterPage()),
      GoRoute(path: '/workouts', builder: (_, _) => const WorkoutsPage()),
      GoRoute(path: '/nutrition', builder: (_, _) => const NutritionPage()),
      GoRoute(path: '/steps', builder: (_, _) => const StepsPage()),
      GoRoute(path: '/progress', builder: (_, _) => const ProgressPage()),
      GoRoute(path: '/ai', builder: (_, _) => const AiPage()),
      GoRoute(path: '/profile', builder: (_, _) => const ProfilePage()),
    ],
  );
});