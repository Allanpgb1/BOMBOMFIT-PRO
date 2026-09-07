import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bombom_fit/app/app.dart';

void main() {
  testWidgets('BOMBOM fit inicia corretamente', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: BombomFitApp(),
      ),
    );

    await tester.pump();

    expect(find.byType(BombomFitApp), findsOneWidget);
  });
}