import 'dart:convert';
import '../models/workout.dart';
import '../services/auth_service.dart';
import '../services/local_storage_service.dart';

class WorkoutRepository {
  static const _workouts = [
    Workout(id: 'treino-1', title: 'Caminhada rápida', description: 'Cardio moderado para começar o dia.', durationMinutes: 30, calories: 180),
    Workout(id: 'treino-2', title: 'Treino de pernas', description: 'Agachamento, avanço e elevação de panturrilha.', durationMinutes: 35, calories: 260),
    Workout(id: 'treino-3', title: 'Treino de braços', description: 'Bíceps, tríceps e ombros.', durationMinutes: 30, calories: 220),
    Workout(id: 'treino-4', title: 'Treino de corpo inteiro', description: 'Circuito completo para força e condicionamento.', durationMinutes: 40, calories: 320),
    Workout(id: 'treino-5', title: 'Alongamento e mobilidade', description: 'Rotina leve para mobilidade.', durationMinutes: 15, calories: 60),
  ];

  Future<List<Workout>> list() async => List.unmodifiable(_workouts);

  Future<void> logWorkout({
    required String workoutId,
    required int durationMinutes,
    required int calories,
  }) async {
    final email = await AuthService().currentUser;
    if (email == null) return;
    final prefs = await LocalStorageService.prefs();
    final key = '${LocalStorageService.workoutLogsKey}_${LocalStorageService.userPrefix(email)}';
    final logs = prefs.getStringList(key) ?? [];
    logs.add(jsonEncode({
      'workout_id': workoutId,
      'duration_minutes': durationMinutes,
      'calories': calories,
      'created_at': DateTime.now().toIso8601String(),
    }));
    await prefs.setStringList(key, logs);
  }
}
