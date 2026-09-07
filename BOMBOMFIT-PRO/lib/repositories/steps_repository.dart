import 'package:intl/intl.dart';
import '../services/auth_service.dart';
import '../services/local_storage_service.dart';

class StepsRepository {
  Future<int> today() async {
    final email = await AuthService().currentUser;
    if (email == null) return 0;
    final prefs = await LocalStorageService.prefs();
    return prefs.getInt('${LocalStorageService.stepsKey}_${LocalStorageService.userPrefix(email)}_${DateFormat('yyyy-MM-dd').format(DateTime.now())}') ?? 0;
  }

  Future<void> saveToday(int steps) async {
    final email = await AuthService().currentUser;
    if (email == null) return;
    final prefs = await LocalStorageService.prefs();
    await prefs.setInt('${LocalStorageService.stepsKey}_${LocalStorageService.userPrefix(email)}_${DateFormat('yyyy-MM-dd').format(DateTime.now())}', steps);
  }
}
