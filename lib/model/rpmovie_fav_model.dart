// To parse this JSON data, do
//
//     final rpMovieFavModel = rpMovieFavModelFromJson(jsonString);

import 'dart:convert';

RpMovieFavModel rpMovieFavModelFromJson(String str) =>
    RpMovieFavModel.fromJson(json.decode(str));

String rpMovieFavModelToJson(RpMovieFavModel data) =>
    json.encode(data.toJson());

class RpMovieFavModel {
  RpMovieFavModel({
    this.id,
    this.originalTitle,
    this.posterPath,
    this.voteAverage,
  });

  int id;
  String originalTitle;
  String posterPath;
  double voteAverage;

  factory RpMovieFavModel.fromJson(Map<String, dynamic> json) =>
      RpMovieFavModel(
        id: json["id"] == null ? null : json["id"],
        originalTitle:
            json["original_title"] == null ? null : json["original_title"],
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        voteAverage: json["vote_average"] == null
            ? null
            : json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "original_title": originalTitle == null ? null : originalTitle,
        "poster_path": posterPath == null ? null : posterPath,
        "vote_average": voteAverage == null ? null : voteAverage,
      };
}
