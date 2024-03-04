import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_mvc/model/user.dart';

void main() {
  group('User model test', () {
    test('creating a user with valid data should succeed', () {
      final user = User(username: 'John', password : 'Admin4158');

      expect(user.username, 'John');
      expect(user.password, 'Admin4158');
    });

    test('fromJson creates a User object from valid JSON', () {
      final Map<String, dynamic> json = {
        'username': 'test_user',
        'password': 'test_password',
      };

      final user = User.fromJson(json);

      expect(user.username, 'test_user');
      expect(user.password, 'test_password');
    });
  });

}