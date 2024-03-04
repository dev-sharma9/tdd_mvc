import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_mvc/controller/login_controller.dart';
import 'package:tdd_mvc/model/login_response.dart';
import 'package:tdd_mvc/utils/app_constants.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  late LoginController loginController;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    loginController = LoginController(mockHttpClient);
  });

  group('Login Controller testing', () {
    test('given loginUser functions when called should return valid success response', () async {
      const username = "michael";
      const password = "success-password";

      when(() => mockHttpClient.post(Uri.parse(AppConstants.apiBaseUrl + AppConstants.methodLogin),
          body: {"username": username, "password": password})).thenAnswer((invocation) async {
        return Response('''
          {
              "success": true,
              "message": "Login successful",
              "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNjgwMjM5MDIyLCJleHAiOjI2MTkzMDAwMDAsImlzcyI6ImJlZWNlcHRvci5jb20iLCJhdWQiOiJCZWVjZXB0b3IgdXNlcnMifQ.D-wEdKyDTOk3GlHs8d2yjfYGZ9gYqWfx2wDPY7mTf-w"
          }
        ''', 200);
      });

      final loginResponse = await loginController.loginUser(username, password);
      expect(loginResponse, isA<LoginResult>());
    });

    test('given loginUser functions with invalid credentials when called should return valid fail response', () async {
      const username = 'username';
      const password = 'fail';

      when(() => mockHttpClient.post(Uri.parse(AppConstants.apiBaseUrl + AppConstants.methodLogin),
      body: {"username":username, "password": password})).thenAnswer((invocation) async {
        return Response('''
          {
              "success": false,
              "error": {
                  "code": "invalid_credentials",
                  "message": "Invalid username or password."
              }
          }
        ''', 200);
      });
      
      expect(loginController.loginUser(username, password), isNot(isA<LoginResponse>()));
    });
  });
}
