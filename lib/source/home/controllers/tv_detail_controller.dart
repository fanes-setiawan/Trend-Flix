import 'package:dio/dio.dart';
import 'package:trendflix/service/api/api.dart';
import 'package:trendflix/service/model/movieModel.dart';

class TvDetailController {
  String? id;
  TvDetailController({this.id});
  bool isFavorite = false;

   Map<String, dynamic>? data;
  List<MovieModel> TvSeriesDetails = [];
  List<MovieModel> TvSeriesReview = [];
  List<MovieModel> similarserieslist = [];
  List<MovieModel> recommendserieslist = [];
  List<MovieModel> seriestrailerslist = [];

  Future<void> getTvDetail() async {
    print("getTvDetail==============++>");
    var tvseriesdetail = "${MyApi.ApiUrl}tv/$id?api_key=${MyApi.ApiKey}";
    var tvseriesreview = "${MyApi.ApiUrl}tv/$id/reviews?api_key=${MyApi.ApiKey}";
    var similarseries = "${MyApi.ApiUrl}tv/$id/similar?api_key=${MyApi.ApiKey}";
    var recommendseries = "${MyApi.ApiUrl}tv/$id/recommendations?api_key=${MyApi.ApiKey}";
    var seriestrailer = "${MyApi.ApiUrl}tv/$id/videos?api_key=${MyApi.ApiKey}";

    print(tvseriesdetail);

    try {
      print("masuk");
      var response1 = await Dio().get(tvseriesdetail);
      print("${response1.statusCode}");
      print("${response1.data}");
      if (response1.statusCode == 200) {
        var data1 = response1.data;
        TvSeriesDetails.add(
          MovieModel(
            name: data1['original_name'] ?? '',
            posterPath: data1['poster_path'] ?? '',
            background_path: data1['backdrop_path'] ?? '',
            title: data1['original_name'] ?? '',
            voteAverage: data1['vote_average'] ?? '',
            overview: data1['overview'] ?? "",
            status: data1['status'] ?? '',
            date: data1['first_air_date'] ?? "",
            genre: (data1['genres'] as List?)?.isNotEmpty == true
                ? (data1['genres'] as List).map((g) => g['name']).join(', ')
                : '',
            creator: (data1['created_by'] as List?)?.isNotEmpty == true
                ? (data1['created_by'] as List).map((c) => c['name']).join(', ')
                : '',
            creatorProfile: (data1['created_by'] as List?)?.isNotEmpty == true
                ? (data1['created_by'] as List).map((c) => c['profile_path']).join(', ')
                : '',
            season: (data1['seasons'] as List?)?.isNotEmpty == true
                ? (data1['seasons'] as List).map((s) => s['name']).join(', ')
                : '',
          ),
        );
      } else {
        print("Error fetching TV details: ${response1.statusCode}");
      }

      var response2 = await Dio().get(tvseriesreview);
      if (response2.statusCode == 200) {
        var data2 = response2.data;
        for (var result in data2['results']) {
          TvSeriesReview.add(
            MovieModel(
              name: result['author'] ?? '',
              review: result['content'] ?? '',
              rating: result['author_details']['rating']?.toString() ?? "Not Rated",
              creationDate: result['author_details']['avatar_path'] ?? '',
              fullReview: result['url'] ?? '',
            ),
          );
        }
      } else {
        print("Error fetching TV reviews: ${response2.statusCode}");
      }

      var response3 = await Dio().get(similarseries);
      if (response3.statusCode == 200) {
        var data3 = response3.data;
        for (var result in data3['results']) {
          similarserieslist.add(
            MovieModel(
              posterPath: result['poster_path'] ?? '',
              name: result['original_name'] ?? '',
              voteAverage: result['vote_average'] ?? '',
              id: result['id'] ?? '',
              date: result['first_air_date'] ?? '',
            ),
          );
        }
      } else {
        print("Error fetching similar series: ${response3.statusCode}");
      }

      var response4 = await Dio().get(recommendseries);
      if (response4.statusCode == 200) {
        var data4 = response4.data;
        for (var result in data4['results']) {
          recommendserieslist.add(
            MovieModel(
              posterPath: result['poster_path'] ?? '',
              name: result['original_name'] ?? '',
              voteAverage: result['vote_average'] ?? '',
              id: result['id'] ?? '',
              date: result['first_air_date'] ?? '',
            ),
          );
        }
      } else {
        print("Error fetching recommended series: ${response4.statusCode}");
      }

      var response5 = await Dio().get(seriestrailer);
      if (response5.statusCode == 200) {
        var data5 = response5.data;
        for (var result in data5['results']) {
          if (result['type'] == 'Trailer') {
            seriestrailerslist.add(
              MovieModel(
                key: result['key'] ?? 'aJ0cZTcTh90',
              ),
            );
          }
        }
      } else {
        print("Error fetching series trailers: ${response5.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print("Dio error! Status: ${e.response?.statusCode}, Data: ${e.response?.data}");
        if (e.response?.statusCode == 404) {
          // Handle 404 error specifically
          print("Resource not found: ${e.response?.data['status_message']}");
        }
      } else {
        print("Error sending request!");
      }
    } catch (e) {
      print("Exception caught: $e");
    }
  }
}
