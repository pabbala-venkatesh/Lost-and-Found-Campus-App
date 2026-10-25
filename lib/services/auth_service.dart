
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<UserCredential> signInWithGoogle() async {
    final GoogleAuthProvider provider = GoogleAuthProvider();

    return await _auth.signInWithPopup(provider);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
