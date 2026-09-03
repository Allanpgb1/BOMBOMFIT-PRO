import 'package:flutter/material.dart';
import '../../../models/workout.dart';
import '../../../repositories/workout_repository.dart';

class WorkoutsPage extends StatefulWidget {
  const WorkoutsPage({super.key});

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  final repo = WorkoutRepository();
  late Future<List<Workout>> future = repo.list();

  Future<void> log(Workout w) async {
    await repo.logWorkout(workoutId: w.id, durationMinutes: w.durationMinutes, calories: w.calories);
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Treino registrado!')));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Treinos')),
        body: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
            final items = snapshot.data ?? <Workout>[];
            if (items.isEmpty) {
              return const Center(child: Text('Nenhum treino cadastrado no Supabase.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: items.length,
              itemBuilder: (_, i) {
                final w = items[i];
                return Card(
                  child: ListTile(
                    title: Text(w.title),
                    subtitle: Text('${w.durationMinutes} min • ${w.calories} kcal'),
                    trailing: IconButton(icon: const Icon(Icons.check_circle_outline), onPressed: () => log(w)),
                  ),
                );
              },
            );
          },
        ),
      );
}
