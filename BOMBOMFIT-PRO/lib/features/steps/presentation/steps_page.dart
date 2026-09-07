import 'package:flutter/material.dart';
import '../../../core/utils/calculations.dart';
import '../../../repositories/profile_repository.dart';
import '../../../repositories/steps_repository.dart';
import '../../../services/health_service.dart';

class StepsPage extends StatefulWidget {
  const StepsPage({super.key});

  @override
  State<StepsPage> createState() => _StepsPageState();
}

class _StepsPageState extends State<StepsPage> {
  final repo = StepsRepository();
  int steps = 0;
  double calories = 0;
  double weight = 70;

  Future<void> load() async {
    final profile = await ProfileRepository().getCurrent();
    final nativeSteps = await HealthService().readTodaySteps();
    final stored = await repo.today();
    final value = nativeSteps > 0 ? nativeSteps : stored;
    if (!mounted) return;
    setState(() {
      steps = value;
      weight = profile?.weightKg ?? 70;
      calories = estimateCaloriesFromSteps(steps: value, weightKg: weight);
    });
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Passos')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text('$steps', style: Theme.of(context).textTheme.displaySmall),
              const Text('passos hoje'),
              const SizedBox(height: 16),
              Text('${calories.round()} kcal estimadas'),
              const SizedBox(height: 24),
              const Text('A integração nativa com HealthKit/Health Connect será conectada na etapa de produção.'),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: () async {
                  final value = await showDialog<int>(
                    context: context,
                    builder: (_) {
                      final c = TextEditingController(text: '$steps');
                      return AlertDialog(
                        title: const Text('Atualizar passos'),
                        content: TextField(controller: c, keyboardType: TextInputType.number),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
                          FilledButton(onPressed: () => Navigator.pop(context, int.tryParse(c.text)), child: const Text('Salvar')),
                        ],
                      );
                    },
                  );
                  if (value != null) {
                    await repo.saveToday(value);
                    await load();
                  }
                },
                icon: const Icon(Icons.edit),
                label: const Text('Atualizar manualmente'),
              ),
            ],
          ),
        ),
      );
}
