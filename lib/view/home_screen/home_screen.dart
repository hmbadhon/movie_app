import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/movie_fav_controller.dart';
import 'package:movie_app/controller/movies_controller.dart';
import 'package:movie_app/controller/movies_details_controller.dart';
import 'package:movie_app/view/favorite/favorite_screen.dart';
import 'package:movie_app/view/home_screen/details_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home_screen';
  final moviesController = Get.put(MoviesController());
  final movieDetailsController = Get.put(MovieDetailsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Popular'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              Navigator.pushNamed(context, FavoriteScreen.routeName);
            },
          ),
        ],
      ),
      body: Obx(
        () {
          if (moviesController.isLoading.isTrue) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              itemCount: moviesController.moviesList.length,
              itemBuilder: (context, int index) {
                return GestureDetector(
                  onTap: () {
                    movieDetailsController.fetchSingleMovie(
                        moviesController.moviesList[index].id);
                    print(moviesController.moviesList[index].id);
                    Navigator.pushNamed(context, DetailsScreen.routeName);
                  },
                  child: Card(
                    elevation: 5,
                    child: GridTile(
                      child: Image.network(
                        'http://image.tmdb.org/t/p/w185'
                        '${moviesController.moviesList[index].posterPath}',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
