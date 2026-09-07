import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../features/auth/providers/auth_providers.dart';
import '../../../repositories/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(title: const Text('Perfil')),
        body: FutureBuilder(
          future: ProfileRepository().getCurrent(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
            final p = snapshot.data;
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                CircleAvatar(radius: 40, child: Text((p?.name?.isNotEmpty ?? false) ? p!.name![0].toUpperCase() : '?')),
                const SizedBox(height: 16),
                Center(child: Text(p?.name ?? 'Usuário', style: Theme.of(context).textTheme.titleLarge)),
                ListTile(title: const Text('Peso'), subtitle: Text('${p?.weightKg ?? '—'} kg')),
                ListTile(title: const Text('Altura'), subtitle: Text('${p?.heightCm ?? '—'} cm')),
                ListTile(title: const Text('Meta de água'), subtitle: Text('${p?.waterGoalMl.round() ?? 0} ml')),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () async {
                    await ref.read(authServiceProvider).signOut();
                    if (context.mounted) context.go('/login');
                  },
                  child: const Text('Sair'),
                ),
              ],
            );
          },
        ),
      );
}
