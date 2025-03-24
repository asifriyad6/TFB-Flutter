// To parse this JSON data, do
//
//     final bookingsModel = bookingsModelFromJson(jsonString);

import 'dart:convert';

List<BookingsModel> bookingsModelFromJson(String str) =>
    List<BookingsModel>.from(
        json.decode(str).map((x) => BookingsModel.fromJson(x)));

String bookingsModelToJson(List<BookingsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingsModel {
  int? id;
  int? customerId;
  int? bookableId;
  String? bookableType;
  String? bookingNo;
  DateTime? schedule;
  String? totalAmount;
  String? payableAmount;
  String? amountPaid;
  String? amountDue;
  String? status;
  String? transactionId;
  String? currency;
  String? gateway;
  DateTime? createdAt;
  DateTime? updatedAt;
  Bookable? bookable;
  List<Cabin>? cabins;
  List<TourDatum>? tourData;

  BookingsModel({
    this.id,
    this.customerId,
    this.bookableId,
    this.bookableType,
    this.bookingNo,
    this.schedule,
    this.totalAmount,
    this.payableAmount,
    this.amountPaid,
    this.amountDue,
    this.status,
    this.transactionId,
    this.currency,
    this.gateway,
    this.createdAt,
    this.updatedAt,
    this.bookable,
    this.cabins,
    this.tourData,
  });

  factory BookingsModel.fromJson(Map<String, dynamic> json) => BookingsModel(
        id: json["id"],
        customerId: json["customer_id"],
        bookableId: json["bookable_id"],
        bookableType: json["bookable_type"],
        bookingNo: json["booking_no"],
        schedule:
            json["schedule"] == null ? null : DateTime.parse(json["schedule"]),
        totalAmount: json["total_amount"],
        payableAmount: json["payable_amount"],
        amountPaid: json["amount_paid"],
        amountDue: json["amount_due"],
        status: json["status"],
        transactionId: json["transaction_id"],
        currency: json["currency"],
        gateway: json["gateway"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        bookable: json["bookable"] == null
            ? null
            : Bookable.fromJson(json["bookable"]),
        cabins: json["cabins"] == null
            ? []
            : List<Cabin>.from(json["cabins"]!.map((x) => Cabin.fromJson(x))),
        tourData: json["tour_data"] == null
            ? []
            : List<TourDatum>.from(
                json["tour_data"]!.map((x) => TourDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "bookable_id": bookableId,
        "bookable_type": bookableType,
        "booking_no": bookingNo,
        "schedule": schedule?.toIso8601String(),
        "total_amount": totalAmount,
        "payable_amount": payableAmount,
        "amount_paid": amountPaid,
        "amount_due": amountDue,
        "status": status,
        "transaction_id": transactionId,
        "currency": currency,
        "gateway": gateway,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "bookable": bookable?.toJson(),
        "cabins": cabins == null
            ? []
            : List<dynamic>.from(cabins!.map((x) => x.toJson())),
        "tour_data": tourData == null
            ? []
            : List<dynamic>.from(tourData!.map((x) => x.toJson())),
      };
}

class Bookable {
  int? id;
  String? title;
  String? thumbnail;
  int? locationId;
  Location? location;

  Bookable({
    this.id,
    this.title,
    this.thumbnail,
    this.locationId,
    this.location,
  });

  factory Bookable.fromJson(Map<String, dynamic> json) => Bookable(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        locationId: json["location_id"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "location_id": locationId,
        "location": location?.toJson(),
      };
}

class Location {
  int? id;
  String? name;
  int? cityId;
  City? city;

  Location({
    this.id,
    this.name,
    this.cityId,
    this.city,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        name: json["name"],
        cityId: json["city_id"],
        city: json["city"] == null ? null : City.fromJson(json["city"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city_id": cityId,
        "city": city?.toJson(),
      };
}

class City {
  int? id;
  String? name;

  City({
    this.id,
    this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Cabin {
  int? id;
  String? cabinNumber;
  String? name;
  int? isAc;
  CabinPivot? pivot;

  Cabin({
    this.id,
    this.cabinNumber,
    this.name,
    this.isAc,
    this.pivot,
  });

  factory Cabin.fromJson(Map<String, dynamic> json) => Cabin(
        id: json["id"],
        cabinNumber: json["cabin_number"],
        name: json["name"],
        isAc: json["isAC"],
        pivot:
            json["pivot"] == null ? null : CabinPivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cabin_number": cabinNumber,
        "name": name,
        "isAC": isAc,
        "pivot": pivot?.toJson(),
      };
}

class CabinPivot {
  int? bookingsId;
  int? houseboatCabinId;
  int? childrenQuantity;
  String? cabinPrice;
  String? childPrice;
  DateTime? createdAt;
  DateTime? updatedAt;

  CabinPivot({
    this.bookingsId,
    this.houseboatCabinId,
    this.childrenQuantity,
    this.cabinPrice,
    this.childPrice,
    this.createdAt,
    this.updatedAt,
  });

  factory CabinPivot.fromJson(Map<String, dynamic> json) => CabinPivot(
        bookingsId: json["bookings_id"],
        houseboatCabinId: json["houseboat_cabin_id"],
        childrenQuantity: json["children_quantity"],
        cabinPrice: json["cabin_price"],
        childPrice: json["child_price"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "bookings_id": bookingsId,
        "houseboat_cabin_id": houseboatCabinId,
        "children_quantity": childrenQuantity,
        "cabin_price": cabinPrice,
        "child_price": childPrice,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class TourDatum {
  int? id;
  int? tourId;
  TourDatumPivot? pivot;

  TourDatum({
    this.id,
    this.tourId,
    this.pivot,
  });

  factory TourDatum.fromJson(Map<String, dynamic> json) => TourDatum(
        id: json["id"],
        tourId: json["tour_id"],
        pivot: json["pivot"] == null
            ? null
            : TourDatumPivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tour_id": tourId,
        "pivot": pivot?.toJson(),
      };
}

class TourDatumPivot {
  int? bookingsId;
  int? tourId;
  int? adultQuantity;
  int? childrenQuantity;
  String? adultPrice;
  String? childPrice;
  DateTime? createdAt;
  DateTime? updatedAt;

  TourDatumPivot({
    this.bookingsId,
    this.tourId,
    this.adultQuantity,
    this.childrenQuantity,
    this.adultPrice,
    this.childPrice,
    this.createdAt,
    this.updatedAt,
  });

  factory TourDatumPivot.fromJson(Map<String, dynamic> json) => TourDatumPivot(
        bookingsId: json["bookings_id"],
        tourId: json["tour_id"],
        adultQuantity: json["adult_quantity"],
        childrenQuantity: json["children_quantity"],
        adultPrice: json["adult_price"],
        childPrice: json["child_price"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "bookings_id": bookingsId,
        "tour_id": tourId,
        "adult_quantity": adultQuantity,
        "children_quantity": childrenQuantity,
        "adult_price": adultPrice,
        "child_price": childPrice,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
