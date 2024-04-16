// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps

class MyApi {
  static String ApiKey = "d9e7c7a800c9b17ad54fbc025b535f38";
  static String ApiUrl = "https://api.themoviedb.org/3/";

  //api tv series
  static String ApiPopuler = "${ApiUrl}tv/popular?api_key=$ApiKey";
  static String ApiTop = "${ApiUrl}tv/top_rated?api_key=$ApiKey";
  static String ApiOnAir = "${ApiUrl}tv/on_the_air?api_key=$ApiKey";

  //api movies
  static String ApiPopulerMovies = "${ApiUrl}movie/popular?api_key=$ApiKey";
  static String ApiNowPlayingMovies =
      "${ApiUrl}movie/now_playing?api_key=$ApiKey";
  static String ApiTopPratedMovies = "${ApiUrl}movie/top_rated?api_key=$ApiKey";
  static String ApiLatesMovies = "${ApiUrl}movie/latest?api_key=$ApiKey";

  //api upcomming
  static String ApiUpcomming = "${ApiUrl}movie/upcoming?api_key=$ApiKey";

  //api search
  static String ApiSearch = "${ApiUrl}/search/multi?api_key=$ApiKey";
}
