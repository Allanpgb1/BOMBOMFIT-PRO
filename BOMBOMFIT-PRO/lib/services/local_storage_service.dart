import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _secure = FlutterSecureStorage();
  static const currentEmailKey = 'bombom_current_email';
  static const profileKey = 'bombom_profile';
  static const waterKey = 'bombom_water_entries';
  static const nutritionKey = 'bombom_nutrition_logs';
  static const stepsKey = 'bombom_steps';
  static const workoutLogsKey = 'bombom_workout_logs';

  static Future<SharedPreferences> prefs() => SharedPreferences.getInstance();

  static String userPrefix(String email) =>
      email.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '_');

  static Future<String?> currentEmail() => _secure.read(key: currentEmailKey);

  static Future<void> setCurrentEmail(String email) =>
      _secure.write(key: currentEmailKey, value: email.trim().toLowerCase());

  static Future<void> clearCurrentEmail() =>
      _secure.delete(key: currentEmailKey);

  static Future<void> savePassword(String email, String password) =>
      _secure.write(key: 'bombom_password_${userPrefix(email)}', value: password);

  static Future<String?> readPassword(String email) =>
      _secure.read(key: 'bombom_password_${userPrefix(email)}');
}
