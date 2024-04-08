// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:trendflix/api/api.dart';
import 'package:trendflix/service/model/movieModel.dart';

class HomeController {
  //tv Series
  List<MovieModel> populartSeries = [];
  List<MovieModel> topratedSeries = [];
  List<MovieModel> onairtSeries = [];

  //movies
  List<MovieModel> popularMovies = [];
  List<MovieModel> nowPlayingMovies = [];
  List<MovieModel> topPratedMovies = [];
  List<MovieModel> latesMovies = [];

  //upcomming
  List<MovieModel> upComming = [];

  Future<void> tvSeriesFunction() async {
    try {
      var response1 = await Dio().get(MyApi.ApiPopuler);
      var data1 = response1.data;
      if (response1.statusCode == 200) {
        var results = data1['results'];
        for (var i = 0; i < results.length; i++) {
          populartSeries.add(
            MovieModel(
              id: results[i]['id'] ?? '',
              name: results[i]['original_name'] ?? '',
              posterPath: results[i]['poster_path'] ?? '',
              voteAverage: results[i]['vote_average'].toDouble(),
              date: results[i]['first_air_date'] ?? '',
            ),
          );
        }
      } else {
        print(response1.statusCode);
      }

      var response2 = await Dio().get(MyApi.ApiTop);
      var data2 = response2.data;

      if (response2.statusCode == 200) {
        var results = data2['results'];
        for (var i = 0; i < results.length; i++) {
          topratedSeries.add(
            MovieModel(
              id: results[i]['id'] ?? '',
              name: results[i]['original_name'] ?? '',
              posterPath: results[i]['poster_path'] ?? '',
              voteAverage: results[i]['vote_average'].toDouble(),
              date: results[i]['first_air_date'] ?? '',
            ),
          );
        }
      } else {
        print(response2.statusCode);
      }
      var response3 = await Dio().get(MyApi.ApiOnAir);
      var data3 = response3.data;
      if (response3.statusCode == 200) {
        var results = data3['results'];
        for (var i = 0; i < results.length; i++) {
          onairtSeries.add(
            MovieModel(
              id: results[i]['id'] ?? '',
              name: results[i]['original_name'] ?? '',
              posterPath: results[i]['poster_path'] ?? '',
              voteAverage: results[i]['vote_average'].toDouble(),
              date: results[i]['first_air_date'] ?? '',
            ),
          );
        }
      } else {
        print(response3.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> moviesFunction() async {
    try {
      var response1 = await Dio().get(MyApi.ApiPopulerMovies);
      var data1 = response1.data;
      if (response1.statusCode == 200) {
        var results = data1['results'];
        for (var i = 0; i < results.length; i++) {
          popularMovies.add(
            MovieModel(
              id: results[i]['id'] ?? '',
              name: results[i]['title'] ?? '',
              posterPath: results[i]['poster_path'] ?? '',
              voteAverage: results[i]['vote_average'].toDouble(),
              date: results[i]['release_date'] ?? '',
            ),
          );
        }
      } else {
        print(response1.statusCode);
      }

      var response2 = await Dio().get(MyApi.ApiNowPlayingMovies);
      var data2 = response2.data;

      if (response2.statusCode == 200) {
        var results = data2['results'];
        for (var i = 0; i < results.length; i++) {
          nowPlayingMovies.add(
            MovieModel(
              id: results[i]['id'] ?? '',
              name: results[i]['title'] ?? '',
              posterPath: results[i]['poster_path'] ?? '',
              voteAverage: results[i]['vote_average'].toDouble(),
              date: results[i]['release_date'] ?? '',
            ),
          );
        }
      } else {
        print(response2.statusCode);
      }
      var response3 = await Dio().get(MyApi.ApiTopPratedMovies);
      var data3 = response3.data;
      if (response3.statusCode == 200) {
        var results = data3['results'];
        for (var i = 0; i < results.length; i++) {
          topPratedMovies.add(
            MovieModel(
              id: results[i]['id'] ?? '',
              name: results[i]['title'] ?? '',
              posterPath: results[i]['poster_path'] ?? '',
              voteAverage: results[i]['vote_average'].toDouble(),
              date: results[i]['release_date'] ?? '',
            ),
          );
        }
      } else {
        print(response3.statusCode);
      }
      var response4 = await Dio().get(MyApi.ApiLatesMovies);
      var data4 = response4.data;
      if (response4.statusCode == 200) {
        var results = data4['results'];
        for (var i = 0; i < results.length; i++) {
          latesMovies.add(
            MovieModel(
              id: results[i]['id'] ?? '',
              name: results[i]['title'] ?? '',
              posterPath: results[i]['poster_path'] ?? '',
              voteAverage: results[i]['vote_average'].toDouble(),
              date: results[i]['release_date'] ?? '',
            ),
          );
        }
      } else {
        print(response3.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUpcomming() async {
    try {
      var response = await Dio().get(MyApi.ApiUpcomming);
      var data = response.data;
      if (response.statusCode == 200) {
        var results = data['results'];
        for (var i = 0; i < results.length; i++) {
          upComming.add(
            MovieModel(
              id: results[i]['id'] ?? '',
              name: results[i]['title'] ?? '',
              posterPath: results[i]['poster_path'] ?? '',
              voteAverage: results[i]['vote_average'].toDouble(),
              date: results[i]['release_date'] ?? '',
            ),
          );
        }
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}
