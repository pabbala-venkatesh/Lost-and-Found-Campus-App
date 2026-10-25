
import 'package:flutter_test/flutter_test.dart';
import 'package:campus_lost_found/main.dart';

void main() {
  testWidgets('Campus Lost & Found app starts', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const LostFoundApp());

    expect(find.byType(LostFoundApp), findsOneWidget);
  });
}
