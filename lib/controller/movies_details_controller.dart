import 'package:get/get.dart';
import 'package:movie_app/model/rpmovie_model.dart';
import 'package:movie_app/services/network_service.dart';

class MovieDetailsController extends GetxController {
  var movieDetails = RpSingleMoviesModel().obs;
  var isLoading = false.obs;

  Future<void> fetchSingleMovie(int id) async {
    try {
      isLoading(true);
      var movie = await NetworkServices().fetchSingleMovie(id);
      if (movie != null) {
        movieDetails.value = movie;
      }
    } finally {
      isLoading(false);
    }
  }
}
