import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presentation_app/main.dart';  // Adjust the import to point to your main file

void main() {
  testWidgets('Number Guessing Game UI Test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the instruction text is displayed.
    expect(find.text('I\'m thinking of a number between 1 and 100.'), findsOneWidget);
  });
}