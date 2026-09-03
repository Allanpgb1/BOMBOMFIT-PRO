import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_providers.dart';
import '../../../services/supabase_service.dart';

class AuthGate extends ConsumerStatefulWidget {
  const AuthGate({super.key});

  @override
  ConsumerState<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<AuthGate> {
  bool _checked = false;
  bool _hasProfile = false;

  Future<void> _check() async {
    final client = SupabaseService.client;
    final user = client?.auth.currentUser;
    if (client == null || user == null) {
      if (mounted) context.go('/login');
      return;
    }
    final row = await client.from('profiles').select('id').eq('id', user.id).maybeSingle();
    if (!mounted) return;
    setState(() {
      _checked = true;
      _hasProfile = row != null;
    });
    context.go(row == null ? '/onboarding' : '/home');
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(_check);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(authStateProvider);
    if (!_checked) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: Center(
        child: Text(_hasProfile ? 'Abrindo Bombom Fit…' : 'Preparando seu perfil…'),
      ),
    );
  }
}
