import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/rpmovie_model.dart';
import 'package:movie_app/model/rpmovies_model.dart';

class NetworkServices {
  static const String baseUrl = "https://api.themoviedb.org/3/movie/";
  static const String apiKey = '?api_key=YOUR_API_KEY';
  static var client = http.Client();

  Future<List<RpMoviesModel>> fetchMovies() async {
    http.Response response = await client.get(baseUrl + 'popular' + apiKey);
    // log(response.body);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['results'];

      List<RpMoviesModel> posts = body
          .map(
            (dynamic item) => RpMoviesModel.fromJson(item),
          )
          .toList();
      print(response.statusCode);
      return posts;
    } else {
      print(response.statusCode);
      throw Exception('Fail to load');
    }
  }

  Future<RpSingleMoviesModel> fetchSingleMovie(int id) async {
    http.Response response = await client.get(baseUrl + id.toString() + apiKey);
    // log(response.body);
    if (response.statusCode == 200) {
      // List<dynamic> body = jsonDecode(response.body);
      //
      // List<RpSingleMoviesModel> posts = body
      //     .map(
      //       (dynamic item) => RpSingleMoviesModel.fromJson(item),
      //     )
      //     .toList();
      var body = jsonDecode(response.body);
      print(response.statusCode);
      return RpSingleMoviesModel.fromJson(body);
    } else {
      print(response.statusCode);
      throw Exception('Fail to load');
    }
  }
}
