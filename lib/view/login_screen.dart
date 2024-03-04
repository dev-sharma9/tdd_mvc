import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_mvc/controller/login_controller.dart';
import 'package:tdd_mvc/model/post.dart';
import 'package:tdd_mvc/utils/validator.dart';

import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final LoginController loginController = LoginController(http.Client());

  void _onClickLogin() async {
    if(_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      Future<List<Post>>? posts= null;

      final loginResult = await loginController.loginUser(username, password);
      if(loginResult.message == 'Success') {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => HomePage(posts: posts,)));
      } else {
        var snackBar = const SnackBar(content: Text('Something went wrong. Please try again.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(label: Text('Username')),
                validator: (value) => Validator.validateUsername(value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text('Password'),
                ),
                validator: (value) => Validator.validatePassword(value),
              ),
            ),
            ElevatedButton(
              onPressed: _onClickLogin,
              key: const Key('Login Button'),
              child: const Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}
