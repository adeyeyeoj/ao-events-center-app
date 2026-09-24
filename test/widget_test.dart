
import 'package:flutter_test/flutter_test.dart';
import 'package:ao_events_center/main.dart';

void main() {
  testWidgets('AO Events Center launches', (tester) async {
    await tester.pumpWidget(const AOEventsApp());
    expect(find.byType(AOEventsApp), findsOneWidget);
  });
}
