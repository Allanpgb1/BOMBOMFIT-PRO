import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Bombom Fit'),
          actions: [
            IconButton(onPressed: () => context.push('/profile'), icon: const Icon(Icons.person_outline)),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Olá! 👋', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            const Text('Seu resumo de hoje'),
            const SizedBox(height: 20),
            _Tile(title: '💧 Hidratação', subtitle: 'Acompanhe sua meta de água', route: '/water'),
            _Tile(title: '🏋️ Treinos', subtitle: 'Escolha seu treino de hoje', route: '/workouts'),
            _Tile(title: '🍎 Nutrição', subtitle: 'Registre suas refeições', route: '/nutrition'),
            _Tile(title: '👟 Passos', subtitle: 'Acompanhe passos e gasto estimado', route: '/steps'),
            _Tile(title: '📈 Progresso', subtitle: 'Veja sua evolução', route: '/progress'),
            _Tile(title: '🤖 Coach IA', subtitle: 'Converse com seu assistente', route: '/ai'),
          ],
        ),
      );
}

class _Tile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String route;
  const _Tile({required this.title, required this.subtitle, required this.route});

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push(route),
        ),
      );
}
