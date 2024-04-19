// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trendflix/navbar.dart';

import '../../../widget_global/typesMovieWidget.dart';

class RegisterController {
  BuildContext context;
  RegisterController({required this.context});
  bool isObscure = true;
  bool isLoading = false;

  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController TextNameControl = TextEditingController();
  TextEditingController TextEmailControl = TextEditingController();
  TextEditingController TextPassControl = TextEditingController();

  bool validateFields() {
    if (TextEmailControl.text.isEmpty ||
        TextNameControl.text.isEmpty ||
        TextPassControl.text.isEmpty) {
      return false;
    }
    return true;
  }

  bool isPasswordSecure(String password) {
    // Panjang minimal password
    if (password.length < 8) {
      return false;
    }

    // Memiliki setidaknya satu huruf besar
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return false;
    }

    // Memiliki setidaknya satu huruf kecil
    if (!password.contains(RegExp(r'[a-z]'))) {
      return false;
    }

    // Memiliki setidaknya satu angka
    if (!password.contains(RegExp(r'[0-9]'))) {
      return false;
    }

    // Memiliki setidaknya satu simbol
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }

    return true;
  }

  regEmailPass() async {
    try {
      if (!validateFields()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                showSnackBarText('name, email, and password must be filled'),
          ),
        );
        return;
      }

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: TextEmailControl.text,
        password: TextPassControl.text,
      );
      final User? user = auth.currentUser;
      if (user != null) {
        final FirebaseFirestore dbAuth = FirebaseFirestore.instance;
        try {
          await dbAuth.collection('users').doc(user.uid).set({
            'name': TextNameControl.text,
            'email': TextEmailControl.text,
            'password': TextPassControl.text,
          });
        } on Exception catch (err) {
          print(err);
        }
      }
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const NavBar(),
        ),
      );
      TextNameControl.clear();
      TextEmailControl.clear();
      TextPassControl.clear();
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: showSnackBarText('failed to register !!!'),
        ),
      );
    }
  }

  regGoogle() async {
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
        const SnackBar(
          content: Text('Gagal melakukan register'),
        ),
      );
    }
  }
}
