import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../repositories/profile_repository.dart';
import '../../../repositories/water_repository.dart';
import '../../../services/notification_service.dart';
class WaterPage extends StatefulWidget {
  const WaterPage({super.key});
  @override
  State<WaterPage> createState() => _WaterPageState();
}
class _WaterPageState extends State<WaterPage> {
  final repo = WaterRepository();
  final profileRepo = ProfileRepository();
  int total = 0;
  double goal = 2000;
  bool loading = true;
  Future<void> load() async {
    setState(() => loading = true);
    final entries = await repo.today();
    final profile = await profileRepo.getCurrent();
    if (!mounted) return;
    setState(() {
      total = entries.fold(0, (sum, e) => sum + e.amountMl);
      goal = profile?.waterGoalMl ?? 2000;
      loading = false;
    });
  }
  Future<void> add(int amount) async {
    await repo.add(amount);
    await load();
  }
  @override
  void initState() {
    super.initState();
    load();
  }
  @override
  Widget build(BuildContext context) {
    final progress = (total / goal).clamp(0.0, 1.0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hidratação'),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    '$total ml / ${goal.round()} ml',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: progress,
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [200, 300, 500]
                        .map(
                          (v) => FilledButton.tonal(
                            onPressed: () => add(v),
                            child: Text('+$v ml'),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () => NotificationService()
                        .scheduleWaterReminder(intervalHours: 2),
                    icon: const Icon(
                      Icons.notifications_active_outlined,
                    ),
                    label: const Text(
                      'Ativar lembrete a cada 2h',
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Atualizado ${DateFormat.Hm().format(DateTime.now())}',
                  ),
                ],
              ),
            ),
    );
  }
}