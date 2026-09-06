import '../repositories/profile_repository.dart';

class LocalCoachService {
  Future<String> answer(String message) async {
    final profile = await ProfileRepository().getCurrent();
    final name = profile?.name?.trim().isNotEmpty == true ? profile!.name! : 'você';
    final text = message.toLowerCase();

    if (text.contains('água') || text.contains('agua')) {
      final goal = profile?.waterGoalMl.round() ?? 2000;
      return '$name, sua meta diária configurada no Bombom Fit é $goal ml. '
          'Distribua o consumo ao longo do dia e acompanhe na tela Hidratação.';
    }
    if (text.contains('treino')) {
      return '$name, priorize consistência: aqueça, faça o treino com boa técnica e respeite seus limites. '
          'O Bombom Fit tem treinos prontos e registra sua evolução no aparelho.';
    }
    if (text.contains('comida') || text.contains('aliment') || text.contains('dieta')) {
      return '$name, mantenha refeições equilibradas, proteína adequada, vegetais e boa hidratação. '
          'Use a área Nutrição para registrar suas refeições.';
    }
    return '$name, posso ajudar com treino, hidratação, alimentação e acompanhamento. '
        'Seja específico sobre o que você quer melhorar e eu vou orientar com as informações disponíveis no app.';
  }
}
