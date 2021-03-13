import 'package:get/get.dart';
import 'package:movie_app/helper/db_helper.dart';
import 'package:movie_app/model/rpmovie_fav_model.dart';
import 'package:movie_app/model/rpmovie_model.dart';
import 'package:movie_app/model/rpmovies_model.dart';

class MovieFavoriteController extends GetxController {
  var products = List<RpMovieFavModel>().obs();
  var isLoading = false.obs;
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    queryAllFav();
    super.onInit();
  }

  void addToFav(RpSingleMoviesModel rpSingleMoviesModel) async {
    RpMovieFavModel rpMovieFavModel = RpMovieFavModel(
      id: rpSingleMoviesModel.id,
      originalTitle: rpSingleMoviesModel.originalTitle,
      posterPath: rpSingleMoviesModel.posterPath,
      voteAverage: rpSingleMoviesModel.voteAverage,
    );
    _databaseHelper.insertFav(rpMovieFavModel);
    var result = await _databaseHelper.queryAllFav();
    if (result.isNotEmpty) {
      products.assignAll(result);
    }
  }

  void removeFromFav(int id) async {
    try {
      isLoading(true);
      await _databaseHelper.deleteFav(id);
      queryAllFav();
    } finally {
      isLoading(false);
    }
  }

  void queryAllFav() async {
    try {
      isLoading(true);
      var product = await _databaseHelper.queryAllFav();
      products.assignAll(product);
    } finally {
      isLoading(false);
    }
  }
}
