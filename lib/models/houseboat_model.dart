import 'dart:convert';

class houseboatRoomRequest {
  String houseboatId;
  String schedule;
  List<Room> rooms;
  houseboatRoomRequest(
      {required this.houseboatId, required this.schedule, required this.rooms});
  Map<String, dynamic> toJson() {
    return {
      'houseboat_id': houseboatId,
      'schedule': schedule,
      'room_person': rooms.map((room) => room.toJson()).toList(),
    };
  }
}

class houseboatCabinRequest {
  String houseboatId;
  String schedule;
  houseboatCabinRequest({required this.houseboatId, required this.schedule});
  Map<String, dynamic> toJson() {
    return {
      'houseboat_id': houseboatId,
      'schedule': schedule,
    };
  }
}

class Room {
  int adults;
  int children;

  Room({this.adults = 1, this.children = 0});
  Map<String, dynamic> toJson() {
    return {'adults': adults, 'children': children};
  }
}

List<HouseboatModel> houseboatModelFromJson(String str) =>
    List<HouseboatModel>.from(
        json.decode(str).map((x) => HouseboatModel.fromJson(x)));

String houseboatModelToJson(List<HouseboatModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HouseboatModel {
  int? id;
  String? slug;
  String? title;
  int? capacity;
  String? thumbnail;
  String? location;
  String? city;
  String? country;
  String? startingPrice;
  String? discountedPrice;
  DateTime? firstSchedule;

  HouseboatModel({
    this.id,
    this.slug,
    this.title,
    this.capacity,
    this.thumbnail,
    this.location,
    this.city,
    this.country,
    this.startingPrice,
    this.discountedPrice,
    this.firstSchedule,
  });

  factory HouseboatModel.fromJson(Map<String, dynamic> json) => HouseboatModel(
        id: json["id"],
        slug: json["slug"],
        title: json["title"],
        capacity: json["capacity"],
        thumbnail: json["thumbnail"],
        location: json["location"],
        city: json["city"],
        country: json["country"],
        startingPrice: json["starting_price"],
        discountedPrice: json["discounted_price"],
        firstSchedule: json["first_schedule"] == null
            ? null
            : DateTime.parse(json["first_schedule"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "title": title,
        "capacity": capacity,
        "thumbnail": thumbnail,
        "location": location,
        "city": city,
        "country": country,
        "starting_price": startingPrice,
        "discounted_price": discountedPrice,
        "first_schedule":
            "${firstSchedule!.year.toString().padLeft(4, '0')}-${firstSchedule!.month.toString().padLeft(2, '0')}-${firstSchedule!.day.toString().padLeft(2, '0')}",
      };
}
