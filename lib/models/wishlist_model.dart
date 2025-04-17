import 'dart:convert';

class WishlistModel {
  int? tourId;
  int? houseboatId;

  WishlistModel({this.tourId, this.houseboatId});

  Map<String, dynamic> addWishlist() {
    return {
      'tour_id': tourId,
      'houseboat_id': houseboatId,
    };
  }
}

List<WishlistResponse> wishlistResponseFromJson(String str) =>
    List<WishlistResponse>.from(
        json.decode(str).map((x) => WishlistResponse.fromJson(x)));

String wishlistResponseToJson(List<WishlistResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WishlistResponse {
  int? id;
  String? title;
  String? thumbnail;
  int? locationId;
  String? location;
  dynamic discountedPrice;
  String? type;

  WishlistResponse({
    this.id,
    this.title,
    this.thumbnail,
    this.locationId,
    this.location,
    this.discountedPrice,
    this.type,
  });

  factory WishlistResponse.fromJson(Map<String, dynamic> json) =>
      WishlistResponse(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        locationId: json["location_id"],
        location: json["location"],
        discountedPrice: json["discounted_price"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "location_id": locationId,
        "location": location,
        "discounted_price": discountedPrice,
        "type": type,
      };
}
