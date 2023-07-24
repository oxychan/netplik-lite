// To parse this JSON data, do
//
//     final movieDetailModel = movieDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:next_starter/data/models/movie/movie_stream_model.dart';

MovieDetailModel movieDetailModelFromJson(String str) =>
    MovieDetailModel.fromJson(json.decode(str));

String movieDetailModelToJson(MovieDetailModel data) =>
    json.encode(data.toJson());

class MovieDetailModel {
  String? id;
  String? title;
  String? type;
  String? posterImg;
  String? quality;
  String? rating;
  String? releaseDate;
  String? duration;
  String? synopsis;
  String? trailerUrl;
  List<String>? genres;
  List<String>? directors;
  List<String>? countries;
  List<String>? casts;
  List<MovieStreamModel>? streams;

  MovieDetailModel({
    required this.id,
    required this.title,
    required this.type,
    required this.posterImg,
    required this.quality,
    required this.rating,
    required this.releaseDate,
    required this.duration,
    required this.synopsis,
    required this.trailerUrl,
    required this.genres,
    required this.directors,
    required this.countries,
    required this.casts,
    required this.streams,
  });

  MovieDetailModel copyWith({
    String? id,
    String? title,
    String? type,
    String? posterImg,
    String? quality,
    String? rating,
    String? releaseDate,
    String? duration,
    String? synopsis,
    String? trailerUrl,
    List<String>? genres,
    List<String>? directors,
    List<String>? countries,
    List<String>? casts,
    List<MovieStreamModel>? streams,
  }) =>
      MovieDetailModel(
        id: id ?? this.id,
        title: title ?? this.title,
        type: type ?? this.type,
        posterImg: posterImg ?? this.posterImg,
        quality: quality ?? this.quality,
        rating: rating ?? this.rating,
        releaseDate: releaseDate ?? this.releaseDate,
        duration: duration ?? this.duration,
        synopsis: synopsis ?? this.synopsis,
        trailerUrl: trailerUrl ?? this.trailerUrl,
        genres: genres ?? this.genres,
        directors: directors ?? this.directors,
        countries: countries ?? this.countries,
        casts: casts ?? this.casts,
        streams: streams ?? [],
      );

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) =>
      MovieDetailModel(
        id: json["_id"],
        title: json["title"],
        type: json["type"],
        posterImg: json["posterImg"],
        quality: json["quality"],
        rating: json["rating"],
        releaseDate: json["releaseDate"],
        duration: json["duration"],
        synopsis: json["synopsis"],
        trailerUrl: json["trailerUrl"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        directors: List<String>.from(json["directors"].map((x) => x)),
        countries: List<String>.from(json["countries"].map((x) => x)),
        casts: List<String>.from(json["casts"].map((x) => x)),
        streams: [],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "type": type,
        "posterImg": posterImg,
        "quality": quality,
        "rating": rating,
        "releaseDate": releaseDate,
        "duration": duration,
        "synopsis": synopsis,
        "trailerUrl": trailerUrl,
        "genres": List<dynamic>.from((genres ?? []).map((x) => x)),
        "directors": List<dynamic>.from((directors ?? []).map((x) => x)),
        "countries": List<dynamic>.from((countries ?? []).map((x) => x)),
        "casts": List<dynamic>.from((casts ?? []).map((x) => x)),
      };
}
