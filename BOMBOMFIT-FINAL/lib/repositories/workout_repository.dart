import '../models/workout.dart';
import '../services/supabase_service.dart';

class WorkoutRepository {
  Future<List<Workout>> list() async {
    final client = SupabaseService.client;
    if (client == null) return [];

    final data = await client.from('workouts').select().eq('is_active', true).order('title');
    return (data as List)
        .map((e) => Workout.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> logWorkout({
    required String workoutId,
    required int durationMinutes,
    required int calories,
  }) async {
    final client = SupabaseService.client;
    final user = client?.auth.currentUser;
    if (client == null || user == null) return;
    await client.from('workout_logs').insert({
      'user_id': user.id,
      'workout_id': workoutId,
      'duration_minutes': durationMinutes,
      'calories': calories,
    });
  }
}
