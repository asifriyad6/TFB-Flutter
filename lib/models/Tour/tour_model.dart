// To parse this JSON data, do
//
//     final tourModel = tourModelFromJson(jsonString);

import 'dart:convert';

List<TourModel> tourModelFromJson(String str) =>
    List<TourModel>.from(json.decode(str).map((x) => TourModel.fromJson(x)));

String tourModelToJson(List<TourModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TourModel {
  int? id;
  String? slug;
  String? title;
  int? maxPeople;
  String? thumbnail;
  String? priceAdult;
  String? location;
  String? city;
  String? country;
  int? discountedPrice;
  DateTime? firstSchedule;
  String? duration;

  TourModel({
    this.id,
    this.slug,
    this.title,
    this.maxPeople,
    this.thumbnail,
    this.priceAdult,
    this.location,
    this.city,
    this.country,
    this.discountedPrice,
    this.firstSchedule,
    this.duration,
  });

  factory TourModel.fromJson(Map<String, dynamic> json) => TourModel(
        id: json["id"],
        slug: json["slug"],
        title: json["title"],
        maxPeople: json["max_people"],
        thumbnail: json["thumbnail"],
        priceAdult: json["price_adult"],
        location: json["location"],
        city: json["city"],
        country: json["country"],
        discountedPrice: json["discounted_price"],
        firstSchedule: json["first_schedule"] == null
            ? null
            : DateTime.parse(json["first_schedule"]),
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "title": title,
        "max_people": maxPeople,
        "thumbnail": thumbnail,
        "price_adult": priceAdult,
        "location": location,
        "city": city,
        "country": country,
        "discounted_price": discountedPrice,
        "first_schedule":
            "${firstSchedule!.year.toString().padLeft(4, '0')}-${firstSchedule!.month.toString().padLeft(2, '0')}-${firstSchedule!.day.toString().padLeft(2, '0')}",
        "duration": duration,
      };
}
