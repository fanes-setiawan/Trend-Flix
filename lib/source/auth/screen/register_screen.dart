import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trendflix/source/auth/controller/register_controller.dart';
import 'package:trendflix/source/auth/screen/login_screen.dart';

import '../../../colors/myColors.dart';
import '../../../widget_global/form_widget.dart';
import '../../../widget_global/typesMovieWidget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final RegisterController _controller;

  @override
  void initState() {
    _controller = RegisterController(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.cBlack,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 35.0,
              ),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/logo/logo_trend_flix.png",
                      width: 120.0,
                      height: 120.0,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      "Register",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "ExpletusSans",
                        color: MyColor.cGrey1,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
              formWidget(
                controller: _controller.TextNameControl,
                title: 'Name',
                hintText: 'your name',
                keyboardType: TextInputType.name,
              ),
              const SizedBox(
                height: 20.0,
              ),
              formWidget(
                controller: _controller.TextEmailControl,
                title: 'Email',
                hintText: 'email@email.com',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20.0,
              ),
              formPassWidget(
                controller: _controller.TextPassControl,
                title: "Password",
                hintText: 'Enter your password',
                obscureText: _controller.isObscure,
                isSuffixIcon: true,
                suffixIcon: IconButton(
                  icon: _controller.isObscure
                      ? Icon(
                          Icons.visibility,
                          color: MyColor.cGrey2,
                        )
                      : Icon(
                          Icons.visibility_off,
                          color: MyColor.cGrey2,
                        ),
                  onPressed: () {
                    _controller.isObscure = !_controller.isObscure;
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: MyColor.cGrey1,
                        backgroundColor: MyColor.cGrey1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide.none,
                      ),
                      onPressed: () async {
                        _controller.isLoading = true;
                        setState(() {});
                        await _controller.regEmailPass();
                        _controller.isLoading = false;
                        setState(() {});
                      },
                      child: !_controller.isLoading
                          ? Tabbartext('Create account')
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                color: MyColor.cGrey2,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: showSnackBarText('-OR-'),
                ),
              ),
              Center(
                child: InkWell(
                  onTap: () async {
                    await _controller.regGoogle();
                  },
                  child: SizedBox(
                    width: 120,
                    height: 60,
                    child: Image.asset('assets/logo/logo_google.png'),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  showSnackBarText('Already have an account?'),
                  const SizedBox(
                    width: 5.0,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          color: MyColor.cWhite,
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
