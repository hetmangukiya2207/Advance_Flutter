import 'package:chat_app_using_firebase/helper/FirestoreHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  AuthHelper._();

  static AuthHelper auth_helper = AuthHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> SigninAnonymous() async {
    UserCredential userCredential = await firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  Future<User?> SignUp(
      {required String email, required String password}) async {
    UserCredential userCredential =
        await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future<Map<String, dynamic>> SignIn(
      {required String email, required String password}) async {
    Map<String, dynamic> res = {};
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      FirestoreHelper.fireStore_Helper.addUser(data: {
        "email": userCredential.user?.email,
        "uid": userCredential.user?.uid,
      });
      res['user'] = userCredential.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.code;
    }
    return res;
  }

  // SigninWith Google
  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    var credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await firebaseAuth.signInWithCredential(credential);

    User? user = userCredential.user;
    FirestoreHelper.fireStore_Helper.addUser(data: {
      "email": user?.email,
      "uid": user?.uid,
    });
    return user;
  }

  void SignOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }
}
