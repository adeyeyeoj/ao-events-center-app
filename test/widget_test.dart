import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AO Admin test', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Text('AO Admin'),
        ),
      ),
    );

    expect(find.text('AO Admin'), findsOneWidget);
  });
}
