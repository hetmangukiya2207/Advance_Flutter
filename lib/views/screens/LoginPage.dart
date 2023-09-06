import 'package:chat_app_using_firebase/helper/AuthHelper.dart';
import 'package:chat_app_using_firebase/views/utils/ImageUtils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      headerWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              AuthHelper.auth_helper.SigninAnonymous().then(
                    (value) => Get.offAllNamed('/'),
                  );
            },
            child: const Text("Sign in Anonymously"),
          ),
          ElevatedButton(
            onPressed: () async {
              User? res = await AuthHelper.auth_helper.signInWithGoogle();
              if (res != null) {
                Get.offAllNamed('/');
              } else {}
            },
            child: const Text("Google Sign in"),
          ),
        ],
      ),
      onSignup: (val) {
        AuthHelper.auth_helper
            .SignUp(email: val.name!, password: val.password!);
        Get.offAllNamed('/');
      },
      logo: AssetImage(
        ImagePath + AppLogo,
      ),
      title: "Chat App",
      initialAuthMode: AuthMode.signup,
      userType: LoginUserType.email,
      onLogin: (LoginData val) async {
        Map<String, dynamic> res = await AuthHelper.auth_helper
            .SignIn(email: val.name, password: val.password);
        if (res['user'] != null) {
          Get.offAllNamed('/');
          Get.snackbar("Chat App", "Login Successfully");
        } else if (res['error'] != null) {
          Get.offAllNamed('/LoginPage');
          Get.snackbar("Chat App", "Login Failed");
        }
      },
      onRecoverPassword: (val) {},
    );
  }
}
