import 'package:flutter_test/flutter_test.dart';

import '../practical10/practical10.dart';

void main() {
  testWidgets('Calculator screen loads', (tester) async {
    await tester.pumpWidget(const CalculatorApp());

    expect(find.text('NOVA'), findsOneWidget);
    expect(find.text('SMART CALCULATOR'), findsOneWidget);
    expect(find.text('AC'), findsOneWidget);
  });

  testWidgets('Calculator adds numbers', (tester) async {
    await tester.pumpWidget(const CalculatorApp());

    await tester.tap(find.text('2'));
    await tester.tap(find.text('+'));
    await tester.tap(find.text('3'));
    await tester.tap(find.text('='));
    await tester.pumpAndSettle();

    expect(find.text('5'), findsOneWidget);
  });

  testWidgets('Calculator clears input', (tester) async {
    await tester.pumpWidget(const CalculatorApp());

    await tester.tap(find.text('8'));
    await tester.tap(find.text('AC'));
    await tester.pumpAndSettle();

    expect(
      find.descendant(
        of: find.byKey(const ValueKey('calculator-display')),
        matching: find.text('0'),
      ),
      findsOneWidget,
    );
  });
}
