import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trendflix/widget_global/typesMovieWidget.dart';

import '../colors/myColors.dart';

Widget formEmailWidget({
  String? title,
  String? hintText,
  bool validate = true,
  void Function()? onPressed,
  TextEditingController? controller,
  void Function(String)? onSubmitted,
  void Function(String)? onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      normaltext(title.toString()),
      Container(
        decoration: BoxDecoration(
          color: MyColor.cGrey1.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: TextField(
          controller: controller,
          style: TextStyle(color: MyColor.cGrey2),
          onSubmitted: onSubmitted,
          onChanged: onChanged,
          cursorColor: MyColor.cGrey2,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
                fontFamily: 'open sans',
                decoration: TextDecoration.none,
                color: MyColor.cGrey2,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.25),
            helperStyle: TextStyle(
              color: MyColor.cGrey2,
            ),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'[a-zA-Z0-9@._-]'),
            ),
          ],
          keyboardType: TextInputType.emailAddress,
        ),
      ),
    ],
  );
}

Widget formPassWidget({
  String? title,
  String? hintText,
  bool? isSuffixIcon = true,
  Widget? suffixIcon,
  bool obscureText = true,
  TextEditingController? controller,
  void Function(String)? onSubmitted,
  void Function(String)? onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      normaltext(title.toString()),
      Container(
        decoration: BoxDecoration(
          color: MyColor.cGrey1.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: TextField(
          obscureText: obscureText,
          controller: controller,
          style: TextStyle(color: MyColor.cGrey2),
          onSubmitted: onSubmitted,
          onChanged: onChanged,
          cursorColor: MyColor.cGrey2,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
                fontFamily: 'open sans',
                decoration: TextDecoration.none,
                color: MyColor.cGrey2,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.25),
            helperStyle: TextStyle(
              color: MyColor.cGrey2,
            ),
          ),
        ),
      ),
    ],
  );
}
