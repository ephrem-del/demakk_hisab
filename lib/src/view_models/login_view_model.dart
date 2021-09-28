import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel {
  Future<bool> authenticate(String email, String password) async {
    bool _isSignedIn = false;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      _isSignedIn = true;
    } on FirebaseAuthException catch (e) {
      return _isSignedIn;
    }
    return _isSignedIn;
  }
}
