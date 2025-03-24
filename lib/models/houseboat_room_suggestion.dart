import 'dart:convert';

class RoomSelection {
  int index;
  int roomId;
  double basePrice;
  double discountedPrice;
  double childPrice;
  double childSum;

  RoomSelection(
      {required this.index,
      required this.roomId,
      required this.basePrice,
      required this.discountedPrice,
      required this.childPrice,
      required this.childSum});
  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'roomId': roomId,
      'basePrice': basePrice,
      'discountedPrice': discountedPrice,
      'childPrice': childPrice,
      'childSum': childSum,
    };
  }
}

List<HouseboatRoomSuggestionModel> houseboatRoomSuggestionModelFromJson(
        String str) =>
    List<HouseboatRoomSuggestionModel>.from(
        json.decode(str).map((x) => HouseboatRoomSuggestionModel.fromJson(x)));

String houseboatRoomSuggestionModelToJson(
        List<HouseboatRoomSuggestionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HouseboatRoomSuggestionModel {
  int? id;
  String? name;
  int? capacity;
  int? bedNumber;
  String? bedSize;
  String? basePrice;
  String? childPrice;
  String? childSum;
  String? discountedPrice;
  List<Amenity>? amenities;

  HouseboatRoomSuggestionModel({
    this.id,
    this.name,
    this.capacity,
    this.bedNumber,
    this.bedSize,
    this.basePrice,
    this.childPrice,
    this.childSum,
    this.discountedPrice,
    this.amenities,
  });

  factory HouseboatRoomSuggestionModel.fromJson(Map<String, dynamic> json) =>
      HouseboatRoomSuggestionModel(
        id: json["id"],
        name: json["name"],
        capacity: json["capacity"],
        bedNumber: json["bed_number"],
        bedSize: json["bed_size"],
        basePrice: json["base_price"],
        childPrice: json["child_price"],
        childSum: json["child_sum"],
        discountedPrice: json["discounted_price"],
        amenities: json["amenities"] == null
            ? []
            : List<Amenity>.from(
                json["amenities"]!.map((x) => Amenity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "capacity": capacity,
        "bed_number": bedNumber,
        "bed_size": bedSize,
        "base_price": basePrice,
        "child_price": childPrice,
        "child_sum": childSum,
        "discounted_price": discountedPrice,
        "amenities": amenities == null
            ? []
            : List<dynamic>.from(amenities!.map((x) => x.toJson())),
      };
}

class Amenity {
  String? name;
  dynamic icon;

  Amenity({
    this.name,
    this.icon,
  });

  factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
        name: json["name"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "icon": icon,
      };
}
