// To parse this JSON data, do
//
//     final bannerImages = bannerImagesFromJson(jsonString);

import 'dart:convert';

List<BannerImages> bannerImagesFromJson(String str) => List<BannerImages>.from(
    json.decode(str).map((x) => BannerImages.fromJson(x)));

String bannerImagesToJson(List<BannerImages> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BannerImages {
  int? id;
  String? name;
  String? platform;
  DateTime? createdAt;
  DateTime? updatedAt;

  BannerImages({
    this.id,
    this.name,
    this.platform,
    this.createdAt,
    this.updatedAt,
  });

  factory BannerImages.fromJson(Map<String, dynamic> json) => BannerImages(
        id: json["id"],
        name: json["name"],
        platform: json["platform"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "platform": platform,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
