class Profile {
  final String id;
  final String? name;
  final int? age;
  final double? weightKg;
  final double? heightCm;
  final int activityMinutes;
  final double waterGoalMl;

  const Profile({
    required this.id,
    this.name,
    this.age,
    this.weightKg,
    this.heightCm,
    this.activityMinutes = 0,
    this.waterGoalMl = 2000,
  });

  factory Profile.fromMap(Map<String, dynamic> map) => Profile(
        id: map['id'] as String,
        name: map['name'] as String?,
        age: (map['age'] as num?)?.toInt(),
        weightKg: (map['weight_kg'] as num?)?.toDouble(),
        heightCm: (map['height_cm'] as num?)?.toDouble(),
        activityMinutes: (map['activity_minutes'] as num?)?.toInt() ?? 0,
        waterGoalMl: (map['water_goal_ml'] as num?)?.toDouble() ?? 2000,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'age': age,
        'weight_kg': weightKg,
        'height_cm': heightCm,
        'activity_minutes': activityMinutes,
        'water_goal_ml': waterGoalMl,
      };
}
