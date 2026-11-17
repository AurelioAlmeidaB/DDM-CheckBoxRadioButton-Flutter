import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:checkbox_radiobutton/main.dart';

// Simula a tela de um celular (412 x 915), como o Pixel do emulador
void telaCelular(WidgetTester tester) {
  tester.view.physicalSize = const Size(1236, 2745);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
}

void main() {
  testWidgets('Sem tamanho escolhido avisa', (WidgetTester tester) async {
    telaCelular(tester);
    await tester.pumpWidget(const Ddm8App());

    await tester.tap(find.text('Enviar'));
    await tester.pump();

    expect(find.text('Produto'), findsNWidgets(2));
    expect(find.text('[]'), findsOneWidget);
    expect(find.text('Nenhum tamanho selecionado'), findsOneWidget);
  });

  testWidgets('Mostra produto, cores e tamanho escolhidos', (WidgetTester tester) async {
    telaCelular(tester);
    await tester.pumpWidget(const Ddm8App());

    await tester.enterText(find.byType(TextField), 'Camiseta');
    await tester.tap(find.text('Branco'));
    await tester.tap(find.text('Verde'));
    await tester.tap(find.text('Pequeno'));
    await tester.tap(find.text('Enviar'));
    await tester.pump();

    expect(find.text('Camiseta'), findsNWidgets(2));
    expect(find.text('[Branco, Verde]'), findsOneWidget);
    expect(find.text('Pequeno'), findsNWidgets(2));
  });
}
