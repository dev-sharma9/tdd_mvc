class User {
  User({
    required this.username,
    required this.password,
  });

  final String? username;
  final String? password;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      username: json["username"],
      password: json["password"],
    );
  }

}
