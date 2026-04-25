import 'package:flutter_test/flutter_test.dart';

import 'package:linkup/main.dart';

void main() {
  testWidgets('LinkUp app boots and shows onboarding', (WidgetTester tester) async {
    await tester.pumpWidget(const LinkUpApp());
    await tester.pump();
    expect(find.text('Freelancer'), findsWidgets);
    expect(find.text('Liga-te às\nmelhores oportunidades'), findsOneWidget);
  });

  testWidgets('Login screen is reachable from onboarding', (WidgetTester tester) async {
    await tester.pumpWidget(const LinkUpApp());
    await tester.pumpAndSettle();
    // Skip directly to last slide to expose "Já tenho conta"
    await tester.tap(find.text('Saltar'));
    await tester.pumpAndSettle();
    // Now on login: should find "Bem-vinda de volta"
    expect(find.text('Bem-vinda de volta'), findsOneWidget);
    expect(find.text('Continuar com Google'), findsOneWidget);
  });

  testWidgets('Switching role does not crash', (WidgetTester tester) async {
    await tester.pumpWidget(const LinkUpApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Empresa'));
    await tester.pumpAndSettle();
    expect(find.text('Para empresas'), findsOneWidget);
  });
}
