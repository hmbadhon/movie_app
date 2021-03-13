import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/movie_fav_controller.dart';
import 'package:movie_app/controller/movies_details_controller.dart';
import 'package:movie_app/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = 'details_screen';
  final MovieDetailsController movieDetailsController = Get.find();
  final movieFavoriteController = Get.put(MovieFavoriteController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Movie Details'),
      ),
      body: Obx(
        () {
          if (movieDetailsController.isLoading.isFalse) {
            if (movieDetailsController.movieDetails.isBlank) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      child: Text(
                        movieDetailsController.movieDetails.value.originalTitle,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        'http://image.tmdb.org/t/p/w185'
                        '${movieDetailsController.movieDetails.value.posterPath}',
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 40),
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                movieDetailsController
                                    .movieDetails.value.releaseDate.year
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${movieDetailsController.movieDetails.value.runtime.minutes.inMinutes}/min',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${movieDetailsController.movieDetails.value.voteAverage}/10 '
                                '(${movieDetailsController.movieDetails.value.voteCount.toString()})',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RaisedButton(
                                onPressed: () {
                                  movieFavoriteController.addToFav(
                                      movieDetailsController
                                          .movieDetails.value);
                                  Get.snackbar(
                                    'Added to favorite',
                                    '',
                                    snackPosition: SnackPosition.BOTTOM,
                                    duration: Duration(milliseconds: 1000),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text('Mark as Favorite'),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                movieDetailsController
                                    .movieDetails.value.status,
                                style: TextStyle(
                                    color: Colors.green, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      movieDetailsController.movieDetails.value.overview,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    child: Text(
                      'Trailer',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: Text(
                      movieDetailsController.movieDetails.value.video
                          .toString(),
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await launch('https://youtu.be/1VIZ89FEjYI');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: Image.network(
                        'https://img.youtube.com/vi/1VIZ89FEjYI/0.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
