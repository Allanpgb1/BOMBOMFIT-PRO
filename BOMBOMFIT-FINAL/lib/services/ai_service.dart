import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';

class AiService {
  Future<String> ask(String message) async {
    final client = SupabaseService.client;
    if (client == null) {
      return _fallback(message);
    }

    try {
      final response = await client.functions.invoke(
        'ai-coach',
        body: {'message': message},
      );
      final data = response.data;
      if (data is Map && data['answer'] is String) {
        return data['answer'] as String;
      }
      return _fallback(message);
    } catch (_) {
      return _fallback(message);
    }
  }

  String _fallback(String message) {
    return 'Posso ajudar com treino, hidratação, alimentação e acompanhamento. '
        'Para recomendações personalizadas, complete seu perfil no Bombom Fit.';
  }
}
