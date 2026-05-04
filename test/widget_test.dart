import 'package:flutter_test/flutter_test.dart';
import 'package:my_ecommerce_app/main.dart';

void main() {
  testWidgets('App load smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TechHubApp());

    expect(find.text('Tech Hub'), findsWidgets);

    expect(find.byType(TechHubApp), findsOneWidget);
  });
}
