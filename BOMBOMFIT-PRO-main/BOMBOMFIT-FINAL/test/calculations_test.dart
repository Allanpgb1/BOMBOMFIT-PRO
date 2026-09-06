import 'package:flutter_test/flutter_test.dart';
import 'package:bombom_fit/core/utils/calculations.dart';

void main() {
  test('calcula meta de água a partir do peso e atividade', () {
    final goal = calculateWaterGoalMl(weightKg: 70, activityMinutes: 30);
    expect(goal, 2700);
  });

  test('calcula IMC', () {
    final bmi = calculateBmi(70, 175);
    expect(bmi, closeTo(22.86, 0.01));
  });
}
