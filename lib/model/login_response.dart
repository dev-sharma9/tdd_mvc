import 'dart:convert';

class LoginResponse {
  LoginResponse({
    required this.success,
    required this.message,
    required this.token,
  });

  final bool? success;
  final String? message;
  final String? token;

  factory LoginResponse.fromMap(Map<String, dynamic> json){
    return LoginResponse(
      success: json["success"],
      message: json["message"],
      token: json["token"],
    );
  }

  factory LoginResponse.fromJson(String source) => LoginResponse.fromMap(json.decode(source));

}

class LoginResult {
  final LoginResponse? loginResponse;
  final String message;
  LoginResult({this.loginResponse, required this.message});
}
