double calculateWaterGoalMl({
  required double weightKg,
  required int activityMinutes,
}) {
  final base = weightKg * 35;
  final activityBonus = (activityMinutes / 30).floor() * 250;
  return (base + activityBonus).clamp(1200, 5000);
}

double calculateBmi(double weightKg, double heightCm) {
  if (heightCm <= 0) return 0;
  final h = heightCm / 100;
  return weightKg / (h * h);
}

double estimateCaloriesFromSteps({
  required int steps,
  required double weightKg,
}) {
  // Estimativa simples; não substitui medição clínica ou dispositivo.
  return steps * weightKg * 0.00045;
}

String bmiLabel(double bmi) {
  if (bmi <= 0) return '—';
  if (bmi < 18.5) return 'Abaixo do peso';
  if (bmi < 25) return 'Faixa saudável';
  if (bmi < 30) return 'Sobrepeso';
  return 'Obesidade';
}
