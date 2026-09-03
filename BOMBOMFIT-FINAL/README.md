# BOMBOM fit PRO

Aplicativo Flutter de fitness com autenticação, perfil, hidratação, treinos, alimentação, passos, progresso e Coach IA, usando Supabase.

## Estrutura

- `lib/` — aplicativo Flutter
- `supabase/migrations/` — banco e RLS
- `supabase/functions/ai-coach/` — Edge Function do Coach IA
- `test/` — testes
- `.github/workflows/` — validação e compatibilidade com o pacote legado

## Configuração

Execute o app passando as variáveis do Supabase:

```bash
flutter pub get
flutter run --dart-define=SUPABASE_URL=https://SEU-PROJETO.supabase.co --dart-define=SUPABASE_ANON_KEY=SUA_CHAVE_ANON
```

No Supabase, execute a migration `supabase/migrations/001_initial_schema.sql`.

## Observação sobre integrações nativas

A camada de passos e notificações está preparada como abstração. Para produção, é necessário habilitar HealthKit no iOS, Health Connect no Android e um plugin de notificações locais, além das respectivas permissões de plataforma.
