// ignore: file_names
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:trendflix/colors/myColors.dart';

Widget tittletext(String title) {
  return Text(title,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontFamily: 'Roboto',
          color: Colors.white.withOpacity(0.9),
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.25));
}

Widget titleBold(String title) {
  return Text(title,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontFamily: 'Roboto',
          color: Colors.white.withOpacity(0.9),
          fontSize: 30,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.25));
}

Widget boldtext(String title) {
  return Text(title,
      style: TextStyle(
          fontFamily: 'open sans',
          decoration: TextDecoration.none,
          color: Colors.white.withOpacity(0.9),
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.25));
}

Widget normaltext(String title) {
  return Text(title,
      maxLines: 1,
      style: TextStyle(
          fontFamily: 'open sans',
          decoration: TextDecoration.none,
          color: Colors.white.withOpacity(0.9),
          fontSize: 15,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25));
}

Widget datetext(String title) {
  return Text(title,
      style: TextStyle(
          fontFamily: 'open sans',
          decoration: TextDecoration.none,
          color: Colors.white.withOpacity(0.9),
          fontSize: 10,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.02));
}

Widget ratingtext(String title) {
  return Text(title,
      style: const TextStyle(
          fontFamily: 'open sans',
          decoration: TextDecoration.none,
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.02));
}

Widget ultratittletext(String title) {
  return Text(title,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontFamily: 'open sans',
          color: Colors.white.withOpacity(0.9),
          fontSize: 25,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.25));
}

Widget genrestext(String title) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: 'open sans',
      decoration: TextDecoration.none,
      color: MyColor.cGrey2,
      fontSize: 12,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.25,
    ),
  );
}

Widget readMore(String title) {
  return ReadMoreText(
    title,
    trimMode: TrimMode.Line,
    trimLines: 2,
    style: TextStyle(
        fontFamily: 'open sans',
        decoration: TextDecoration.none,
        color: Colors.white.withOpacity(0.9),
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.25),
    colorClickableText: MyColor.cGrey1,
    annotations: [
      Annotation(
        regExp: RegExp(r'#([a-zA-Z0-9_]+)'),
        spanBuilder: ({required String text, TextStyle? textStyle}) => TextSpan(
          text: text,
          style: TextStyle(
              fontFamily: 'open sans',
              decoration: TextDecoration.none,
              color: Colors.white.withOpacity(0.9),
              fontSize: 13,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.25),
        ),
      ),
      Annotation(
        regExp: RegExp(r'<@(\d+)>'),
        spanBuilder: ({required String text, TextStyle? textStyle}) => TextSpan(
          text: title,
          style: TextStyle(
              fontFamily: 'open sans',
              decoration: TextDecoration.none,
              color: Colors.white.withOpacity(0.9),
              fontSize: 13,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.25),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              // Handle tap, e.g., navigate to a user profile
            },
        ),
      ),
      // Additional annotations for URLs...
    ],
    moreStyle: TextStyle(
        fontFamily: 'open sans',
        decoration: TextDecoration.none,
        color: MyColor.cGrey1,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.25),
  );
}

Widget readMoreChat(String title) {
  return ReadMoreText(
    title,
    trimMode: TrimMode.Line,
    trimLines: 4,
    style: TextStyle(
        fontFamily: 'open sans',
        decoration: TextDecoration.none,
        color: Colors.white.withOpacity(0.9),
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.25),
    colorClickableText: MyColor.cBlack,
    annotations: [
      Annotation(
        regExp: RegExp(r'#([a-zA-Z0-9_]+)'),
        spanBuilder: ({required String text, TextStyle? textStyle}) => TextSpan(
          text: text,
          style: TextStyle(
              fontFamily: 'open sans',
              decoration: TextDecoration.none,
              color: Colors.white.withOpacity(0.9),
              fontSize: 13,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.25),
        ),
      ),
      Annotation(
        regExp: RegExp(r'<@(\d+)>'),
        spanBuilder: ({required String text, TextStyle? textStyle}) => TextSpan(
          text: title,
          style: TextStyle(
              fontFamily: 'open sans',
              decoration: TextDecoration.none,
              color: Colors.white.withOpacity(0.9),
              fontSize: 13,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.25),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              // Handle tap, e.g., navigate to a user profile
            },
        ),
      ),
      // Additional annotations for URLs...
    ],
    moreStyle: TextStyle(
        fontFamily: 'open sans',
        decoration: TextDecoration.none,
        color: MyColor.cBlack,
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.25),
  );
}

Widget showSnackBarText(String title) {
  return Text(title,
      style: TextStyle(
          fontFamily: 'open sans',
          decoration: TextDecoration.none,
          color: MyColor.cGrey1,
          fontSize: 11,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.25));
}

// ignore: non_constant_identifier_names
Widget Tabbartext(String title) {
  return Text(title,
      style: TextStyle(
          fontFamily: 'open sans',
          decoration: TextDecoration.none,
          color: Colors.white.withOpacity(1),
          fontSize: 15,
          fontWeight: FontWeight.w500,
          letterSpacing: 1));
}

Widget overviewtext(String title) {
  return Text(title,
      style: TextStyle(
          fontFamily: 'open sans',
          decoration: TextDecoration.none,
          color: Colors.white.withOpacity(0.9),
          fontSize: 15,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.25));
}
