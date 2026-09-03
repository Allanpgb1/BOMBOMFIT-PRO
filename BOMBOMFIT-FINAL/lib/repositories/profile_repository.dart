import '../models/profile.dart';
import '../services/supabase_service.dart';

class ProfileRepository {
  Future<Profile?> getCurrent() async {
    final client = SupabaseService.client;
    final user = client?.auth.currentUser;
    if (client == null || user == null) return null;

    final data = await client.from('profiles').select().eq('id', user.id).maybeSingle();
    if (data == null) return null;
    return Profile.fromMap(data);
  }

  Future<void> upsert(Profile profile) async {
    final client = SupabaseService.client;
    if (client == null) throw StateError('Supabase não configurado.');
    await client.from('profiles').upsert(profile.toMap());
  }
}
