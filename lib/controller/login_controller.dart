import 'package:tdd_mvc/utils/app_constants.dart';

import '../model/login_response.dart';
import 'package:http/http.dart' as http;

class LoginController {
  final http.Client client;
  LoginController(this.client);

  Future<LoginResult> loginUser(String username, String password) async{
    final response = await client.post(
      Uri.parse(AppConstants.apiBaseUrl + AppConstants.methodLogin),
      body: {
        "username": username,
        "password": password
      }
    );
    if(response.statusCode == 200) {
      return LoginResult(message: 'Success', loginResponse : LoginResponse.fromJson(response.body));
    }
    return LoginResult(message: 'Fail', loginResponse : null);
  }
}