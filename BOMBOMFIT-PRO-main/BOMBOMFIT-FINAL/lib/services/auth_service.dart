import 'local_storage_service.dart';

class LocalAuthState {
  final String email;
  const LocalAuthState(this.email);
}

class AuthService {
  Future<String?> get currentUser async => LocalStorageService.currentEmail();

  Future<bool> get hasSession async =>
      (await LocalStorageService.currentEmail()) != null;

  Future<void> signIn(String email, String password) async {
    final normalized = email.trim().toLowerCase();
    if (normalized.isEmpty || password.isEmpty) {
      throw ArgumentError('Informe e-mail e senha.');
    }
    final saved = await LocalStorageService.readPassword(normalized);
    if (saved == null) {
      throw StateError('Conta não encontrada neste celular. Crie uma conta primeiro.');
    }
    if (saved != password) {
      throw StateError('Senha incorreta.');
    }
    await LocalStorageService.setCurrentEmail(normalized);
  }

  Future<void> signUp(String email, String password) async {
    final normalized = email.trim().toLowerCase();
    if (normalized.isEmpty || password.length < 6) {
      throw ArgumentError('Informe um e-mail e uma senha com pelo menos 6 caracteres.');
    }
    final saved = await LocalStorageService.readPassword(normalized);
    if (saved != null) {
      throw StateError('Esta conta já existe neste celular. Faça login.');
    }
    await LocalStorageService.savePassword(normalized, password);
    await LocalStorageService.setCurrentEmail(normalized);
  }

  Future<void> signOut() => LocalStorageService.clearCurrentEmail();
}
