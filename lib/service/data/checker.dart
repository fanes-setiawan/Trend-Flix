// ignore_for_file: camel_case_types, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:trendflix/source/home/screen/movie_detail_screen.dart';
import 'package:trendflix/source/home/screen/tv_detail_screen.dart';

class descriptioncheckui extends StatefulWidget {
  var newid;
  var newtype;
  descriptioncheckui(this.newid, this.newtype);

  @override
  State<descriptioncheckui> createState() => _descriptioncheckuiState();
}

class _descriptioncheckuiState extends State<descriptioncheckui> {
  checktype() {
    if (widget.newtype.toString() == 'movie') {
      return MovieDetailScreen(
        id: widget.newid,
      );
    } else if (widget.newtype.toString() == 'tv') {
      return TvDetailScreen(id: widget.newid);
    } else if (widget.newtype.toString() == 'person') {
      // return persondescriptionui(widget.id);
    } else {
      return errorui(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return checktype();
  }
}

Widget errorui(context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Error'),
    ),
    body: Center(
      child: Text('no Such page found'),
    ),
  );
}
