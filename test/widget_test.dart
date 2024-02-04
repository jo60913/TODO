import 'package:flutter_test/flutter_test.dart';
import 'package:todo/application/app/basic_app.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {

    await tester.pumpWidget(BaseApp());

    expect(find.text('1'), findsNothing);

  });
}
