import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_mvc/main.dart';
import 'package:tdd_mvc/view/login_screen.dart';

void main() {
  group('', () {
    testWidgets('Home Page contains Login Screen', (tester) async {
      const testWidget = MyApp();

      await tester.pumpWidget(testWidget);

      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}