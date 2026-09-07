# BOMBOM fit — versão 100% local

Aplicativo Flutter de saúde, treino, hidratação, nutrição, passos e progresso.

## Armazenamento
Esta versão **não usa Supabase, banco externo ou servidor obrigatório**.

- Perfil e histórico: armazenamento local do aparelho (`shared_preferences`).
- Credenciais locais: armazenamento seguro do sistema (`flutter_secure_storage`).
- Treinos: catálogo local embutido no aplicativo.
- Nutrição, água, passos e registros de treino: salvos no aparelho.
- Coach: respostas locais, sem Edge Function.
- O aplicativo pode funcionar sem internet para as funções locais.

> Os dados ficam no dispositivo. Se o aplicativo for desinstalado, os dados locais podem ser apagados pelo sistema.

## Como gerar Android
```bash
flutter pub get
flutter analyze
flutter test
flutter build apk --release
flutter build appbundle --release
```

## Como gerar iOS
```bash
flutter pub get
flutter analyze
flutter test
flutter build ipa --release --no-codesign
```

A assinatura da Apple continua dependendo dos certificados/provisioning profiles da conta Apple.

## Estrutura
- `lib/features/` — telas e funcionalidades
- `lib/repositories/` — persistência local
- `lib/services/local_storage_service.dart` — armazenamento local
- `lib/services/auth_service.dart` — autenticação local
- `lib/services/local_coach_service.dart` — coach local

## iOS via GitHub Actions

O workflow `.github/workflows/ios.yml` está configurado para a branch `principal`.
Ele cria a pasta `ios/` automaticamente quando necessário, instala CocoaPods, executa análise/testes e gera o IPA sem assinatura Apple.

No GitHub: **Actions → Build BOMBOM fit iOS → Run workflow → principal**.

O IPA sem assinatura serve para validar a compilação. Para instalar/distribuir no iPhone, é necessário configurar assinatura Apple (Apple Developer, certificado e provisioning profile).

### iOS no GitHub Actions

O workflow `Build BOMBOM fit iOS` usa a branch `principal` e cria/recria a plataforma iOS quando necessário, garantindo a presença do `ios/Podfile` antes da instalação do CocoaPods.
