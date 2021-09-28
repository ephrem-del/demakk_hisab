import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:demakk_hisab/src/view_models/authentication_view_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:hisab_meyaza/src/routes.dart';
import 'package:local_auth/local_auth.dart';

import 'routes.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final _pinController = TextEditingController();
  final _nameController = TextEditingController();
  late AuthenticationViewModel _authenticationViewModel;
  int _trialsLeft = 3;
  late LocalAuthentication _localAuth;

  @override
  void initState() {
    _localAuth = LocalAuthentication();
    _authenticationViewModel = AuthenticationViewModel();
    super.initState();
  }

  authenticate(context) {
    bool _authenticated = false;
    if (_trialsLeft <= 0) {
      SystemNavigator.pop();
    }
    setState(() {
      _trialsLeft = _trialsLeft - 1;
    });
    final int _pin = int.parse(_pinController.text);
    final String _name = _nameController.text;
    _authenticated = _authenticationViewModel.authenticate(_name, _pin);
    if (_authenticated) {
      Navigator.pushReplacementNamed(context, RouteGenerator.homePage);
    }
  }

  Future<bool> localAuth() async {
    if (await _localAuth.canCheckBiometrics) {
      return false;
    }
    try {
      final authSuccess = await _localAuth.authenticate(
          localizedReason: 'መተግበሪያውን ለመጠቀም አሻራዎን ያስገቡ',
          biometricOnly: true,
          stickyAuth: true);
      return authSuccess;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedTextKit(
              pause: const Duration(milliseconds: 1),
              repeatForever: true,
              animatedTexts: [
                ColorizeAnimatedText(
                  'ሂሳብ መያዣ',
                  speed: const Duration(seconds: 1),
                  textStyle: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                  colors: [
                    Colors.amber,
                    Colors.red,
                    Colors.yellow,
                    Colors.purple,
                    Colors.blue,
                    Colors.green,
                    Colors.teal,
                    Colors.orange
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            const SizedBox(height: 10),
            Text('$_trialsLeft ሙከራ ይቀራል'),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 30,
              width: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'ስም',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 150,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _nameController,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 30,
              width: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'የይለፍ ቃል',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 150,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _pinController,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                authenticate(context);
              },
              child: const Text('ግባ'),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
