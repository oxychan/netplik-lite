// To parse this JSON data, do
//
//     final movieStreamModel = movieStreamModelFromJson(jsonString);

import 'dart:convert';

List<MovieStreamModel> movieStreamModelFromJson(String str) =>
    List<MovieStreamModel>.from(
        json.decode(str).map((x) => MovieStreamModel.fromJson(x)));

String movieStreamModelToJson(List<MovieStreamModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MovieStreamModel {
  String provider;
  String url;
  List<String> resolutions;

  MovieStreamModel({
    required this.provider,
    required this.url,
    required this.resolutions,
  });

  MovieStreamModel copyWith({
    String? provider,
    String? url,
    List<String>? resolutions,
  }) =>
      MovieStreamModel(
        provider: provider ?? this.provider,
        url: url ?? this.url,
        resolutions: resolutions ?? this.resolutions,
      );

  factory MovieStreamModel.fromJson(Map<String, dynamic> json) =>
      MovieStreamModel(
        provider: json["provider"],
        url: json["url"],
        resolutions: List<String>.from(json["resolutions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "provider": provider,
        "url": url,
        "resolutions": List<dynamic>.from(resolutions.map((x) => x)),
      };
}
