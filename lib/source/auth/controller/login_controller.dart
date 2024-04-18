// ignore_for_file: non_constant_identifier_names, avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../navbar.dart';

class LoginController {
  BuildContext context;
  LoginController({required this.context});

  bool isObscure = true;
  bool isLoading = false;

  TextEditingController TextEmailControl = TextEditingController();
  TextEditingController TextPassControl = TextEditingController();

  loginEmailPass() async {
    try {
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
      print(err);
    }
  }
}
