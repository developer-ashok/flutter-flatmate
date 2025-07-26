// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Future<UserCredential> signUpWithEmail(String email, String password) async {
  //   final credential = await _auth.createUserWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  //   await credential.user?.sendEmailVerification();
  //   return credential;
  // }

  // Future<UserCredential> signInWithEmail(String email, String password) async {
  //   return await _auth.signInWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  // }

  // Future<void> signOut() async {
  //   await _auth.signOut();
  // }

  // Future<void> sendEmailVerification() async {
  //   final user = _auth.currentUser;
  //   if (user != null && !user.emailVerified) {
  //     await user.sendEmailVerification();
  //   }
  // }

  // Future<UserCredential?> signInWithGoogle() async {
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   if (googleUser == null) return null;
  //   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //   return await _auth.signInWithCredential(credential);
  // }
} 