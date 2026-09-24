import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AO Events Center test', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Text('AO Events Center'),
        ),
      ),
    );

    expect(find.text('AO Events Center'), findsOneWidget);
  });
}
