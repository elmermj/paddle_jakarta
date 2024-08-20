import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paddle_jakarta/data/helpers/web_client_id_helper.dart';
import 'package:paddle_jakarta/utils/tools/log.dart';

class RemoteUserDataSource {
  final FirebaseAuth _firebaseAuth;

  RemoteUserDataSource(this._firebaseAuth);

  Future<void> loginEmail(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Log.red('Failed to login with email: $e');
      throw Exception('Failed to login: $e');
    }
  }

  Future<UserCredential> loginGoogle() async {
    late GoogleSignIn googleSignIn;
    try {
      if(kIsWeb){
        String clientId = await WebClientIdHelper.getWebClientId();
        googleSignIn = GoogleSignIn(
          clientId: clientId,
        );
      } else {
        googleSignIn = GoogleSignIn();
      }
      await googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        Log.red('Google sign-in aborted by user');
        throw Exception('Google sign-in aborted by user');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      Log.yellow('Google sign-in successful');

      return userCredential;      
    } catch (e) {
      final err = e.toString()=="popup_closed"? "Google sign-in aborted by user":e;
      throw Exception('$err');
    }
  }

  Future<void> registerEmail(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Log.red('Failed to register with email: $e');
      throw Exception('Failed to register: $e');
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('$e');
    }
  }
}
