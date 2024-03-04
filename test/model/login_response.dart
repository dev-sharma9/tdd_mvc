import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_mvc/model/login_response.dart';

void main() {
  group('Login response model test', () {
    test('creating a Login response model with valid data should succeed', () {
      final response = LoginResponse(
        success: true,
        message: "Login successful",
        token: "123456789"
      );

      expect(response.success, true);
      expect(response.message, "Login successful");
      expect(response.token, "123456789");

    });
  });
}