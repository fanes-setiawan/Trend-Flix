// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:dio/dio.dart';
import 'package:trendflix/service/api/api.dart';
import 'package:trendflix/service/model/movieModel.dart';

class TvDetailController {
  String? id;
  TvDetailController({this.id});
  bool isFavorite = false;

  var data;
  List<MovieModel> TvSeriesDetails = [];
  List<MovieModel> TvSeriesReview = [];
  List<MovieModel> similarserieslist = [];
  List<MovieModel> recommendserieslist = [];
  List<MovieModel> seriestrailerslist = [];

  Future<void> getTvDetail() async {
    var tvseriesdetail = "${MyApi.ApiUrl}/tv/$id?api_key=${MyApi.ApiKey}";
    var tvseriesreview =
        "${MyApi.ApiUrl}/tv/$id/reviews?api_key=${MyApi.ApiKey}";
    var similarseries =
        "${MyApi.ApiUrl}/tv/$id/similar?api_key=${MyApi.ApiKey}";
    var recommendseries =
        "${MyApi.ApiUrl}/tv/$id/recommendations?api_key=${MyApi.ApiKey}";
    var seriestrailer = "${MyApi.ApiUrl}/tv/$id/videos?api_key=${MyApi.ApiKey}";

    var response1 = await Dio().get(tvseriesdetail);

    print("RESPONSE 1");
    print(response1.statusCode);
    if (response1.statusCode == 200) {
      data = response1.data;
      var data1 = response1.data;
      for (var i = 0; i < 1; i++) {
        TvSeriesDetails.add(
          MovieModel(
            name: data1['original_name'],
            posterPath: data1['poster_path'],
            background_path: data1['backdrop_path'],
            title: data1['original_name'],
            voteAverage: data1['vote_average'],
            overview: data1['overview'],
            status: data1['status'],
            date: data1['first_air_date'],
          ),
        );
      }
      for (var i = 0; i < data1['genres'].length; i++) {
        TvSeriesDetails.add(
          MovieModel(
            genre: data1['genres'][i]['name'] ?? "",
          ),
        );
      }
      for (var i = 0; i < data1['created_by'].length; i++) {
        TvSeriesDetails.add(
          MovieModel(
            creator: data1['created_by'][i]['name'],
            creatorProfile: data1['created_by'][i]['profile_path'],
          ),
        );
      }
      for (var i = 0; i < data1['seasons'].length; i++) {
        TvSeriesDetails.add(
          MovieModel(
            season: data1['seasons'][i]['name'],
            // episodeCount: data1['seasons'][i]['episode_count'],
          ),
        );
      }
    } else {}
    var response2 = await Dio().get(tvseriesreview);

    print("RESPONSE 2");
    print(response2.statusCode);
    if (response2.statusCode == 200) {
      var data2 = response2.data;
      for (var i = 0; i < data2['results'].length; i++) {
        TvSeriesReview.add(
          MovieModel(
            name: data2['results'][i]['author'],
            review: data2['results'][i]['content'],
            rating: data2['results'][i]['author_details']['rating'] == null
                ? "Not Rated"
                : data2['results'][i]['author_details']['rating'].toString(),
            creationDate: data2['results'][i]['author_details']['avatar_path'],
            fullReview: data2['results'][i]['url'] ?? '',
          ),
        );
      }
    } else {}

    var response3 = await Dio().get(similarseries);

    print("RESPONSE 3");
    print(response3.statusCode);
    if (response3.statusCode == 200) {
      var data3 = response3.data;
      for (var i = 0; i < data3['results'].length; i++) {
        similarserieslist.add(
          MovieModel(
            posterPath: data3['results'][i]['poster_path'],
            name: data3['results'][i]['original_name'],
            voteAverage: data3['results'][i]['vote_average'],
            id: data3['results'][i]['id'],
            date: data3['results'][i]['first_air_date'],
          ),
        );
      }
      print('seselai');
    } else {}

    var response4 = await Dio().get(recommendseries);
    print("RESPONSE 4");

    print(response4.statusCode);
    if (response4.statusCode == 200) {
      var data4 = response4.data;
      for (var i = 0; i < data4['results'].length; i++) {
        recommendserieslist.add(
          MovieModel(
            posterPath: data4['results'][i]['poster_path'],
            name: data4['results'][i]['original_name'],
            voteAverage: data4['results'][i]['vote_average'],
            id: data4['results'][i]['id'],
            date: data4['results'][i]['first_air_date'],
          ),
        );
      }
    } else {}

    var response5 = await Dio().get(seriestrailer);

    print("RESPONSE 5");
    print(seriestrailer);

    print(response5.statusCode);
    if (response5.statusCode == 200) {
      var data5 = response5.data;
      print(data5);
      for (var i = 0; i < data5['results'].length; i++) {
        if (data5['results'][i]['type'] == 'Trailer') {
          seriestrailerslist.add(
            MovieModel(
              key: data5['results'][i]['key'] ?? 'aJ0cZTcTh90',
            ),
          );
        }
      }
      seriestrailerslist.add(
        MovieModel(
          key: "aJ0cZTcTh90",
        ),
      );
    } else {}
    try {} catch (e) {
      print(e);
    }
  }
}
