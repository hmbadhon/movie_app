import 'package:get/get.dart';
import 'package:movie_app/model/rpmovies_model.dart';
import 'package:movie_app/services/network_service.dart';

class MoviesController extends GetxController {
  var moviesList = List<RpMoviesModel>().obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchMovies();
    super.onInit();
  }

  void fetchMovies() async {
    try {
      isLoading(true);
      var movies = await NetworkServices().fetchMovies();
      if (movies != null) {
        moviesList.assignAll(movies);
      }
    } finally {
      isLoading(false);
    }
  }
}
