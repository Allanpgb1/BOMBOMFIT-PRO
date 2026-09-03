import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = StreamProvider.autoDispose((ref) {
  return ref.watch(authServiceProvider).authState;
});
