import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  Auth._();
  static final Auth auth = Auth._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences sharedPreferences;
  Future<SharedPreferences> initSp() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences;
    } else {
      return sharedPreferences;
    }
  }

  Future<String> createUserUsingEmailAndPassword(
      String email, String password) async {
    try {
      sharedPreferences = await initSp();
      AuthResult authResult = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      assert(authResult.user != null);
      String userId = authResult.user.uid;
      sharedPreferences.setString('userId', userId);
      sharedPreferences.setBool('isLogged', true);
      return userId;
    } catch (error) {
      print(error);
    }
  }

  Future<String> signInUserUsingEmailAndPassword(
      String email, String password) async {
    try {
      sharedPreferences = await initSp();
      AuthResult authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      assert(authResult.user != null);
      String userId = authResult.user.uid;
      sharedPreferences.setString('userId', userId);
      sharedPreferences.setBool('isLogged', true);
      return userId;
    } catch (error) {
      print(error);
    }
  }

  signOut() async {
    sharedPreferences = await initSp();
    sharedPreferences.setBool('isLogged', false);
    sharedPreferences.setString('userId', '');
    firebaseAuth.signOut();
  }
}
