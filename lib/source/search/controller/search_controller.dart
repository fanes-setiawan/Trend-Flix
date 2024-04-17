// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trendflix/service/api/api.dart';

import '../../../service/model/movieModel.dart';

class SearchControllers {
  final TextEditingController searchtext = TextEditingController();
  bool showlist = false;
  var val1;
  List<MovieModel> SearchResults = [];

  Future<void> getSearchData(velue) async {
    print("data di pnggil");
    var Api = "${MyApi.ApiSearch}&query=$velue";
    var response = await Dio().get(Api);
    print("Data search");
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      var data = response.data;
      var dataSearch = data['results'];
      for (var i = 0; i < dataSearch.length; i++) {
        if (dataSearch[i]['id'] != null &&
            dataSearch[i]['poster_path'] != null &&
            dataSearch[i]['vote_average'] != null &&
            dataSearch[i]['media_type'] != null) {
          print("add movie");
          print(dataSearch[i]['popularity']);
          SearchResults.add(
            MovieModel(
              id: dataSearch[i]['id'],
              posterPath: dataSearch[i]['poster_path'],
              voteAverage: dataSearch[i]['vote_average'],
              mediatype: dataSearch[i]['media_type'],
              title: dataSearch[i]['original_name'],
              date: dataSearch[i]['first_air_date'],
              popularity: dataSearch[i]['popularity'],
              overview: dataSearch[i]['overview'],
            ),
          );
          print("data behasil");
          if (SearchResults.length > 15) {
            print("lebih dari 15");
            SearchResults.removeRange(15, SearchResults.length);
          } else {
            print('null');
          }
        }
      }
      print(SearchResults.length);
    }
  }
}
