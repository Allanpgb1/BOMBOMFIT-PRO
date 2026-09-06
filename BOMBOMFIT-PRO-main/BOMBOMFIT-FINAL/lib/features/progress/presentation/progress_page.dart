import 'package:flutter/material.dart';
import '../../../core/utils/calculations.dart';
import '../../../repositories/profile_repository.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: ProfileRepository().getCurrent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) return const Scaffold(body: Center(child: CircularProgressIndicator()));
          final p = snapshot.data;
          final bmi = calculateBmi(p?.weightKg ?? 0, p?.heightCm ?? 0);
          return Scaffold(
            appBar: AppBar(title: const Text('Progresso')),
            body: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Card(child: ListTile(title: const Text('Peso atual'), subtitle: Text('${p?.weightKg?.toStringAsFixed(1) ?? '—'} kg'))),
                Card(child: ListTile(title: const Text('IMC estimado'), subtitle: Text('${bmi.toStringAsFixed(1)} • ${bmiLabel(bmi)}'))),
                Card(child: ListTile(title: const Text('Meta de água'), subtitle: Text('${p?.waterGoalMl.round() ?? 0} ml/dia'))),
                const SizedBox(height: 12),
                const Text('Histórico de peso e métricas será alimentado pela tabela progress_logs.'),
              ],
            ),
          );
        },
      );
}
