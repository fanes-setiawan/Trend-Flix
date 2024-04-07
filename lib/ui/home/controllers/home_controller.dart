import 'package:dio/dio.dart';
import 'package:trendflix/api/api.dart';
import 'package:trendflix/service/model/movieModel.dart';

class HomeController {
  List<MovieModel> populartSeries = [];
  List<MovieModel> topratedSeries = [];
  List<MovieModel> onairtSeries = [];

  Future<void> tvSeriesFunction() async {
    try {
      var response1 = await Dio().get(MyApi.ApiPopuler);
      print(MyApi.ApiPopuler);
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
        // ignore: avoid_print
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
        // ignore: avoid_print
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
        // ignore: avoid_print
        print(response3.statusCode);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
