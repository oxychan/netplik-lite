import 'dart:convert';

List<MovieModel> movieModelFromJson(String str) =>
    List<MovieModel>.from(json.decode(str).map((x) => MovieModel.fromJson(x)));

String movieModelToJson(List<MovieModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MovieModel {
  String id;
  String title;
  Type type;
  PosterImg posterImg;
  String rating;
  String url;
  QualityResolution qualityResolution;
  List<String> genres;

  MovieModel({
    required this.id,
    required this.title,
    required this.type,
    required this.posterImg,
    required this.rating,
    required this.url,
    required this.qualityResolution,
    required this.genres,
  });

  MovieModel copyWith({
    String? id,
    String? title,
    Type? type,
    PosterImg? posterImg,
    String? rating,
    String? url,
    QualityResolution? qualityResolution,
    List<String>? genres,
  }) =>
      MovieModel(
        id: id ?? this.id,
        title: title ?? this.title,
        type: type ?? this.type,
        posterImg: posterImg ?? this.posterImg,
        rating: rating ?? this.rating,
        url: url ?? this.url,
        qualityResolution: qualityResolution ?? this.qualityResolution,
        genres: genres ?? this.genres,
      );

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json["_id"],
        title: json["title"],
        type: typeValues.map[json["type"]]!,
        posterImg: posterImgValues.map[json["posterImg"]]!,
        rating: json["rating"],
        url: json["url"],
        qualityResolution:
            qualityResolutionValues.map[json["qualityResolution"]]!,
        genres: List<String>.from(json["genres"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "type": typeValues.reverse[type],
        "posterImg": posterImgValues.reverse[posterImg],
        "rating": rating,
        "url": url,
        "qualityResolution": qualityResolutionValues.reverse[qualityResolution],
        "genres": List<dynamic>.from(genres.map((x) => x)),
      };
}

enum PosterImg { HTTPS_UNDEFINED }

final posterImgValues =
    EnumValues({"https:undefined": PosterImg.HTTPS_UNDEFINED});

enum QualityResolution { HD, CAM }

final qualityResolutionValues =
    EnumValues({"CAM": QualityResolution.CAM, "HD": QualityResolution.HD});

enum Type { MOVIE }

final typeValues = EnumValues({"movie": Type.MOVIE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
