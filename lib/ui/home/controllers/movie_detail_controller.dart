// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print
import 'package:dio/dio.dart';

import '../../../service/api/api.dart';
import '../../../service/model/movieModel.dart';

class MovieDetailController {
  String? id;
  MovieDetailController({
    this.id,
  });
  bool isFavorite = false;

  List<MovieModel> MovieDetails = [];
  List<MovieModel> UserReviews = [];
  List<MovieModel> SimilarMovie = [];
  List<MovieModel> RecommendedMovie = [];
  List<MovieModel> MovieTrailers = [];
  var MoviesGeneres;

  Future<void> getDetailMovie() async {
    var moviedetailurl = "${MyApi.ApiUrl}/movie/$id?api_key=${MyApi.ApiKey}";
    var userreviewurl =
        "${MyApi.ApiUrl}/movie/$id/reviews?api_key=${MyApi.ApiKey}";
    var similarseries =
        "${MyApi.ApiUrl}/movie/$id/similar?api_key=${MyApi.ApiKey}";
    var recommendseries =
        "${MyApi.ApiUrl}/movie/$id/recommendations?api_key=${MyApi.ApiKey}";
    var movietrailersurl =
        "${MyApi.ApiUrl}/movie/$id/videos?api_key=${MyApi.ApiKey}";

    var response1 = await Dio().get(moviedetailurl);
    print("RESPONSE1");
    if (response1.statusCode == 200) {
      var data1 = response1.data;
      MoviesGeneres = data1;
      for (var i = 0; i < 1; i++) {
        MovieDetails.add(
          MovieModel(
            background_path: data1['backdrop_path'],
            title: data1['title'],
            voteAverage: data1['vote_average'],
            overview: data1['overview'],
            date: data1['release_date'],

            // runtime: data1['runtime'],
            // revenue: data1['revenue'],
          ),
        );
      }
      for (var i = 0; i < data1['genres'].length; i++) {
        MovieDetails.add(
          MovieModel(
            genre: data1['genres'][i]['name'] ?? '',
          ),
        );
      }
    } else {}
    var response2 = await Dio().get(userreviewurl);
    print("RESPONSE2");
    if (response2.statusCode == 200) {
      var data2 = response2.data;
      for (var i = 0; i < data2['results'].length; i++) {
        UserReviews.add(
          MovieModel(
            name: data2['results'][i]['author'],
            review: data2['results'][i]['content'],
            rating: data2['results'][i]['author_details']['rating'] == null
                ? "Not Rated"
                : data2['results'][i]['author_details']['rating'].toString(),
            avatarPhoto: data2['results'][i]['author_details']['avatar_path'] ==
                    null
                ? "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"
                : "https://image.tmdb.org/t/p/w500" +
                    data2['results'][i]['author_details']['avatar_path'],
            creationDate: data2['results'][i]['created_at'].substring(0, 10),
            fullReview: data2['results'][i]['url'],
          ),
        );
      }
    } else {}

    var response3 = await Dio().get(similarseries);

    print("RESPONSE3");
    if (response3.statusCode == 200) {
      var data3 = response3.data;
      for (var i = 0; i < data3['results'].length; i++) {
        SimilarMovie.add(
          MovieModel(
            posterPath: data3['results'][i]['poster_path'],
            name: data3['results'][i]['title'],
            voteAverage: data3['results'][i]['vote_average'],
            date: data3['results'][i]['release_date'],
            id: data3['results'][i]['id'],
          ),
        );
      }
    } else {}

    var response4 = await Dio().get(movietrailersurl);

    print("RESPONSE4");
    if (response4.statusCode == 200) {
      var data4 = response4.data;
      for (var i = 0; i < data4['results'].length; i++) {
        if (data4['results'][i]['type'] == 'Trailer') {
          MovieTrailers.add(
            MovieModel(
              key: data4['results'][i]['key'],
            ),
          );
        }
      }
      MovieTrailers.add(MovieModel(key: 'aJ0cZTcTh90'));
    } else {}

    var response5 = await Dio().get(recommendseries);

    print("RESPONSE5");
    if (response5.statusCode == 200) {
      var data5 = response5.data;
      for (var i = 0; i < data5['results'].length; i++) {
        RecommendedMovie.add(
          MovieModel(
            posterPath: data5['results'][i]['poster_path'],
            name: data5['results'][i]['title'],
            voteAverage: data5['results'][i]['vote_average'],
            date: data5['results'][i]['release_date'],
            id: data5['results'][i]['id'],
          ),
        );
      }
    } else {}
  }
}
