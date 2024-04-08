// ignore_for_file: non_constant_identifier_names

class MyApi {
  static String ApiKey = "api_key";

  //api tv series
  static String ApiPopuler =
      "https://api.themoviedb.org/3/tv/popular?api_key=$ApiKey";
  static String ApiTop =
      "https://api.themoviedb.org/3/tv/top_rated?api_key=$ApiKey";
  static String ApiOnAir =
      "https://api.themoviedb.org/3/tv/on_the_air?api_key=$ApiKey";

  //api movies
  static String ApiPopulerMovies =
      "https://api.themoviedb.org/3/movie/popular?api_key=$ApiKey";
  static String ApiNowPlayingMovies =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=$ApiKey";
  static String ApiTopPratedMovies =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=$ApiKey";
  static String ApiLatesMovies =
      "https://api.themoviedb.org/3/movie/latest?api_key=$ApiKey";
}
