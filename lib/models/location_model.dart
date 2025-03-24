// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

List<LocationModel> locationModelFromJson(String str) =>
    List<LocationModel>.from(
        json.decode(str).map((x) => LocationModel.fromJson(x)));

String locationModelToJson(List<LocationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationModel {
  int? id;
  int? cityId;
  int? countryId;
  String? slug;
  String? name;
  String? thumbnail;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? houseboatCount;
  int? tourCount;

  LocationModel({
    this.id,
    this.cityId,
    this.countryId,
    this.slug,
    this.name,
    this.thumbnail,
    this.createdAt,
    this.updatedAt,
    this.houseboatCount,
    this.tourCount,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        id: json["id"],
        cityId: json["city_id"],
        countryId: json["country_id"],
        slug: json["slug"],
        name: json["name"],
        thumbnail: json["thumbnail"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        houseboatCount: json["houseboat_count"],
        tourCount: json["tour_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city_id": cityId,
        "country_id": countryId,
        "slug": slug,
        "name": name,
        "thumbnail": thumbnail,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "houseboat_count": houseboatCount,
        "tour_count": tourCount,
      };
}
