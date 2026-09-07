import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../repositories/profile_repository.dart';
import '../../../services/auth_service.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_check);
  }

  Future<void> _check() async {
    final email = await AuthService().currentUser;
    if (!mounted) return;
    if (email == null) {
      context.go('/login');
      return;
    }
    final profile = await ProfileRepository().getCurrent();
    if (!mounted) return;
    context.go(profile == null ? '/onboarding' : '/home');
  }

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: CircularProgressIndicator()));
}
