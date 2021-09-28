import 'package:demakk_hisab/src/view_models/login_view_model.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  late LoginViewModel _loginViewModel;

  @override
  void initState() {
    super.initState();
    _loginViewModel = LoginViewModel();
  }

  _authenticate() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    bool isAuthenticated = false;
    isAuthenticated = await _loginViewModel.authenticate(email, password);
    if (isAuthenticated) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Sign in')),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 300,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('Email:'),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: _emailController,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 300,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('Password:'),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: _passwordController,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  _authenticate();
                },
                child: Text('Sign in'),
              ),
            ],
          ),
        ));
  }
}
