// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../navbar.dart';
import '../../../widget_global/typesMovieWidget.dart';

class LoginController {
  BuildContext context;
  LoginController({required this.context});

  bool isObscure = true;
  bool isLoading = false;

  TextEditingController TextEmailControl = TextEditingController();
  TextEditingController TextPassControl = TextEditingController();

  bool validateFields() {
    if (TextEmailControl.text.isEmpty || TextPassControl.text.isEmpty) {
      return false;
    }
    return true;
  }

  loginEmailPass() async {
    try {
      if (!validateFields()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: showSnackBarText('email and password must be filled in'),
          ),
        );
        return;
      }

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: TextEmailControl.text,
        password: TextPassControl.text,
      );
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const NavBar(),
        ),
      );
      TextEmailControl.clear();
      TextPassControl.clear();
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: showSnackBarText('Incorrect email or password'),
        ),
      );
    }
  }

  loginGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
        ],
      );

      try {
        await googleSignIn.disconnect();
      } catch (_) {}

      try {
        GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount!.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        var userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        debugPrint("userCredential: $userCredential");
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const NavBar(),
          ),
        );
      } catch (_) {}
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: showSnackBarText('failed to log in with Google !!!'),
        ),
      );
    }
  }

  loginAnony() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const NavBar(),
        ),
      );
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: showSnackBarText('failed to perform anonymous login!!!'),
        ),
      );
    }
  }
}
