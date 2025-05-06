import 'dart:convert';

class CabinSelection {
  final int boatId;
  final int cabinId;
  final String cabinNumber;
  int children;
  double basePrice;
  double childPrice;
  double bookingPrice;
  double totalAmount;

  CabinSelection({
    required this.boatId,
    required this.cabinId,
    required this.cabinNumber,
    required this.children,
    required this.basePrice,
    required this.childPrice,
    required this.bookingPrice,
    required this.totalAmount,
  });
  Map<String, dynamic> toJson() {
    return {
      'cabin_id': cabinId,
      'children_quantity': children,
    };
  }
}

List<HouseboatCabin> houseboatCabinFromJson(String str) =>
    List<HouseboatCabin>.from(
        json.decode(str).map((x) => HouseboatCabin.fromJson(x)));

String houseboatCabinToJson(List<HouseboatCabin> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HouseboatCabin {
  int? id;
  String? cabinNumber;
  String? name;
  int? capacity;
  int? bedNumber;
  String? bedSize;
  String? basePrice;
  String? childPrice;
  String? bookingPrice;
  String? discountedPrice;
  int? colPosition;
  int? rowPosition;
  int? isAc;
  bool? isBooked;
  int? isAvailable;

  HouseboatCabin({
    this.id,
    this.cabinNumber,
    this.name,
    this.capacity,
    this.bedNumber,
    this.bedSize,
    this.basePrice,
    this.childPrice,
    this.bookingPrice,
    this.discountedPrice,
    this.colPosition,
    this.rowPosition,
    this.isAc,
    this.isBooked,
    this.isAvailable,
  });

  factory HouseboatCabin.fromJson(Map<String, dynamic> json) => HouseboatCabin(
        id: json["id"],
        cabinNumber: json["cabin_number"],
        name: json["name"],
        capacity: json["capacity"],
        bedNumber: json["bed_number"],
        bedSize: json["bed_size"],
        basePrice: json["base_price"],
        childPrice: json["child_price"],
        bookingPrice: json["booking_price"],
        discountedPrice: json["discounted_price"],
        colPosition: json["col_position"],
        rowPosition: json["row_position"],
        isAc: json["isAC"],
        isBooked: json["is_booked"],
        isAvailable: json["is_available"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cabin_number": cabinNumber,
        "name": name,
        "capacity": capacity,
        "bed_number": bedNumber,
        "bed_size": bedSize,
        "base_price": basePrice,
        "child_price": childPrice,
        "booking_price": bookingPrice,
        "discounted_price": discountedPrice,
        "col_position": colPosition,
        "row_position": rowPosition,
        "isAC": isAc,
        "is_booked": isBooked,
        "is_available": isAvailable,
      };
}
