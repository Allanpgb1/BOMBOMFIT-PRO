# BOMBOM FIT PRO

Base completa do Bombom Fit em Flutter + Supabase.

## Stack
- Flutter/Dart
- Riverpod
- go_router
- Supabase Auth + Postgres + RLS
- Arquitetura por features
- Configuração por `--dart-define`

## Blocos incluídos

1. Fundação e tema
2. Configuração e segurança
3. Autenticação
4. Onboarding/perfil
5. Dashboard
6. Água, meta diária e lembretes
7. Treinos
8. Nutrição
9. Passos e gasto calórico
10. Progresso
11. Coach IA
12. Perfil/configurações
13. Supabase + RLS
14. Testes básicos
15. Preparação para evolução premium/admin

## Como iniciar

```bash
flutter create .
flutter pub get

flutter run \
  --dart-define=SUPABASE_URL=https://SEU-PROJETO.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=SUA_ANON_KEY
```

Depois aplique `supabase/migrations/001_initial_schema.sql` no SQL Editor do Supabase.

### Variáveis

Nunca coloque `service_role` no aplicativo.

Use somente:
- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`

## IA

A tela de IA funciona com um modo local seguro quando a Edge Function não está configurada.
Para produção, publique `supabase/functions/ai-coach` e mantenha a chave do provedor de IA exclusivamente no ambiente da Edge Function.

## Próximos passos de produção

- conectar HealthKit/Health Connect para passos reais;
- configurar notificações nativas;
- adicionar storage para avatar;
- adicionar billing/assinatura;
- adicionar observabilidade;
- revisar políticas RLS em ambiente de staging;
- executar `flutter analyze` e `flutter test`;
- gerar builds Android/iOS.

