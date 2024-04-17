// ignore_for_file: avoid_print, deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../service/db_sqflite/database_helper.dart';
import '../../../service/model/sqflite_model.dart';

class FavoriteController {
  late List<SqfliteModel> movies;
  final BuildContext context;
  bool isLoading = true;

  FavoriteController({required this.context});

  Future<void> getDataFavorite() async {
    isLoading = true;
    try {
      List<SqfliteModel> movieList = await DatabaseHelper().getMoviesLocal();

      movies = movieList;
    } on DioError catch (e) {
      print('Error: $e');
    } on Exception catch (e) {
      print('Error: $e');
    } finally {
      isLoading = false;
    }
  }
}
