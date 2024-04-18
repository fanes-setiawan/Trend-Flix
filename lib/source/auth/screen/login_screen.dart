import 'package:flutter/material.dart';
import 'package:trendflix/colors/myColors.dart';
import 'package:trendflix/source/auth/controller/login_controller.dart';
import 'package:trendflix/source/auth/screen/register_screen.dart';
import 'package:trendflix/widget_global/form_widget.dart';
import 'package:trendflix/widget_global/typesMovieWidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginController _controller;

  @override
  void initState() {
    _controller = LoginController(context: context);
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
                      "Log In",
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
              const SizedBox(
                height: 20.0,
              ),
              showSnackBarText('Log in with one of the following options.'),
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
                        await _controller.loginGoogle();
                      },
                      child: Tabbartext('Google'),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: MyColor.cGrey1,
                        backgroundColor: MyColor.cRed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide.none,
                      ),
                      onPressed: () {
                        _controller.loginAnony();
                      },
                      child: Tabbartext('Anonymous'),
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
              formEmailWidget(
                controller: _controller.TextEmailControl,
                title: 'Email',
                hintText: 'email@email.com',
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
                      onPressed: () {
                        _controller.isLoading = true;
                        setState(() {});
                        _controller.loginEmailPass();
                        _controller.isLoading = false;
                        setState(() {});
                      },
                      child: !_controller.isLoading
                          ? Tabbartext('Log in')
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  showSnackBarText('Don\'t have a account?'),
                  const SizedBox(
                    width: 5.0,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Register",
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
