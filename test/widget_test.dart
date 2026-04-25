import 'package:flutter_test/flutter_test.dart';

import 'package:linkup/main.dart';

void main() {
  testWidgets('LinkUp app boots', (WidgetTester tester) async {
    await tester.pumpWidget(const LinkUpApp());
    await tester.pump();
    expect(find.text('Freelancer'), findsWidgets);
  });
}
