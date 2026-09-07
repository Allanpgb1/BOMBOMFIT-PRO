class Workout {
  final String id;
  final String title;
  final String? description;
  final int durationMinutes;
  final int calories;

  const Workout({
    required this.id,
    required this.title,
    this.description,
    this.durationMinutes = 30,
    this.calories = 0,
  });

  factory Workout.fromMap(Map<String, dynamic> map) => Workout(
        id: map['id'] as String,
        title: map['title'] as String,
        description: map['description'] as String?,
        durationMinutes: (map['duration_minutes'] as num?)?.toInt() ?? 30,
        calories: (map['calories'] as num?)?.toInt() ?? 0,
      );
}
