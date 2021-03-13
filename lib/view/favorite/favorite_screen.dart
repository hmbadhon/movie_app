import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/movie_fav_controller.dart';
import 'package:movie_app/controller/movies_details_controller.dart';
import 'package:movie_app/view/home_screen/details_screen.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = 'favorite_screen';
  final movieFavoriteController = Get.put(MovieFavoriteController());
  final MovieDetailsController movieDetailsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Favorites'),
      ),
      body: Obx(
        () {
          if (movieFavoriteController.isLoading.isFalse) {
            if (movieFavoriteController.products.isEmpty) {
              return Center(
                child: Text(
                  'Empty Favorites!',
                  style: TextStyle(fontSize: 50),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: movieFavoriteController.products.length,
                itemBuilder: (context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      await movieDetailsController.fetchSingleMovie(
                          movieFavoriteController.products[index].id);
                      Navigator.pushNamed(context, DetailsScreen.routeName);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          leading: Container(
                            child: Image.network(
                              'http://image.tmdb.org/t/p/w185${movieFavoriteController.products[index].posterPath}',
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(movieFavoriteController
                              .products[index].originalTitle),
                          subtitle: Text(
                            '${movieFavoriteController.products[index].voteAverage}/10',
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              // Get.dialog();
                              Get.defaultDialog(
                                title: 'Are you sure?',
                                content: Text('It will delete this item'),
                                onConfirm: () {
                                  movieFavoriteController.removeFromFav(
                                      movieFavoriteController
                                          .products[index].id);
                                  Navigator.pop(context);
                                  Get.snackbar(
                                    'Deleted',
                                    '',
                                    snackPosition: SnackPosition.BOTTOM,
                                    duration: Duration(milliseconds: 1000),
                                  );
                                },
                                onCancel: () {},
                              );
                              // print('index: ${index.toString()}');
                              // print(
                              //     'length: ${cartController.products[index].toString()}');
                            },
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  );
                },
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
