import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/calculations.dart';
import '../../../models/profile.dart';
import '../../../repositories/profile_repository.dart';
import '../../../services/auth_service.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final name = TextEditingController();
  final age = TextEditingController();
  final weight = TextEditingController();
  final height = TextEditingController();
  final activity = TextEditingController(text: '30');
  bool loading = false;

  Future<void> save() async {
    final user = await AuthService().currentUser;
    if (user == null) {
      if (mounted) context.go('/login');
      return;
    }
    final weightKg = double.tryParse(weight.text.replaceAll(',', '.')) ?? 70;
    final activityMinutes = int.tryParse(activity.text) ?? 30;
    final water = calculateWaterGoalMl(
      weightKg: weightKg,
      activityMinutes: activityMinutes,
    );

    setState(() => loading = true);
    try {
      await ProfileRepository().upsert(Profile(
        id: user,
        name: name.text.trim(),
        age: int.tryParse(age.text),
        weightKg: weightKg,
        heightCm: double.tryParse(height.text.replaceAll(',', '.')),
        activityMinutes: activityMinutes,
        waterGoalMl: water,
      ));
      if (mounted) context.go('/home');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  void dispose() {
    for (final c in [name, age, weight, height, activity]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Vamos personalizar')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: ListView(
            children: [
              TextField(controller: name, decoration: const InputDecoration(labelText: 'Nome')),
              const SizedBox(height: 12),
              TextField(controller: age, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Idade')),
              const SizedBox(height: 12),
              TextField(controller: weight, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Peso (kg)')),
              const SizedBox(height: 12),
              TextField(controller: height, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Altura (cm)')),
              const SizedBox(height: 12),
              TextField(controller: activity, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Minutos de atividade/dia')),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: loading ? null : save,
                child: Text(loading ? 'Salvando…' : 'Continuar'),
              ),
            ],
          ),
        ),
      );
}
