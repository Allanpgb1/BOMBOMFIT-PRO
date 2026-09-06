import 'local_coach_service.dart';

class AiService {
  Future<String> ask(String message) => LocalCoachService().answer(message);
}
