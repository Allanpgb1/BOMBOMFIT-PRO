import 'package:flutter/material.dart';
import '../../../repositories/nutrition_repository.dart';

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  final repo = NutritionRepository();
  late Future<List<Map<String, dynamic>>> future = repo.today();

  Future<void> addMeal() async {
    await repo.add(meal: 'Refeição', calories: 400, protein: 25, carbs: 45, fat: 12);
    setState(() => future = repo.today());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Nutrição')),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: addMeal,
          label: const Text('Adicionar'),
          icon: const Icon(Icons.add),
        ),
        body: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
            final meals = snapshot.data ?? [];
            if (meals.isEmpty) return const Center(child: Text('Nenhuma refeição registrada hoje.'));
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: meals.length,
              itemBuilder: (_, i) {
                final m = meals[i];
                return Card(child: ListTile(
                  title: Text('${m['meal']}'),
                  subtitle: Text('${m['calories'] ?? 0} kcal • P ${m['protein_g'] ?? 0}g • C ${m['carbs_g'] ?? 0}g • G ${m['fat_g'] ?? 0}g'),
                ));
              },
            );
          },
        ),
      );
}
