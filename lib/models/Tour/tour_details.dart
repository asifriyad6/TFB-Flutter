// To parse this JSON data, do
//
//     final tourDetails = tourDetailsFromJson(jsonString);

import 'dart:convert';

TourDetails tourDetailsFromJson(String str) =>
    TourDetails.fromJson(json.decode(str));

String tourDetailsToJson(TourDetails data) => json.encode(data.toJson());

class TourDetails {
  int? id;
  int? locationId;
  int? userId;
  String? title;
  String? slug;
  String? description;
  String? highlights;
  String? visibleSpots;
  int? minPeople;
  int? maxPeople;
  String? priceAdult;
  String? priceChild;
  int? childAge;
  String? bookingPrice;
  String? includes;
  String? excludes;
  String? thumbnail;
  String? type;
  int? status;
  int? featured;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? discountedPrice;
  DateTime? firstSchedule;
  String? duration;
  List<Image>? images;
  List<Itinerary>? itineraries;
  Location? location;
  List<Schedule>? schedule;

  TourDetails({
    this.id,
    this.locationId,
    this.userId,
    this.title,
    this.slug,
    this.description,
    this.highlights,
    this.visibleSpots,
    this.minPeople,
    this.maxPeople,
    this.priceAdult,
    this.priceChild,
    this.childAge,
    this.bookingPrice,
    this.includes,
    this.excludes,
    this.thumbnail,
    this.type,
    this.status,
    this.featured,
    this.createdAt,
    this.updatedAt,
    this.discountedPrice,
    this.firstSchedule,
    this.duration,
    this.images,
    this.itineraries,
    this.location,
    this.schedule,
  });

  factory TourDetails.fromJson(Map<String, dynamic> json) => TourDetails(
        id: json["id"],
        locationId: json["location_id"],
        userId: json["user_id"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        highlights: json["highlights"],
        visibleSpots: json["visible_spots"],
        minPeople: json["min_people"],
        maxPeople: json["max_people"],
        priceAdult: json["price_adult"],
        priceChild: json["price_child"],
        childAge: json["child_age"],
        bookingPrice: json["booking_price"],
        includes: json["includes"],
        excludes: json["excludes"],
        thumbnail: json["thumbnail"],
        type: json["type"],
        status: json["status"],
        featured: json["featured"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        discountedPrice: json["discounted_price"],
        firstSchedule: json["first_schedule"] == null
            ? null
            : DateTime.parse(json["first_schedule"]),
        duration: json["duration"],
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
        itineraries: json["itineraries"] == null
            ? []
            : List<Itinerary>.from(
                json["itineraries"]!.map((x) => Itinerary.fromJson(x))),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        schedule: json["schedule"] == null
            ? []
            : List<Schedule>.from(
                json["schedule"]!.map((x) => Schedule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "location_id": locationId,
        "user_id": userId,
        "title": title,
        "slug": slug,
        "description": description,
        "highlights": highlights,
        "visible_spots": visibleSpots,
        "min_people": minPeople,
        "max_people": maxPeople,
        "price_adult": priceAdult,
        "price_child": priceChild,
        "child_age": childAge,
        "booking_price": bookingPrice,
        "includes": includes,
        "excludes": excludes,
        "thumbnail": thumbnail,
        "type": type,
        "status": status,
        "featured": featured,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "discounted_price": discountedPrice,
        "first_schedule":
            "${firstSchedule!.year.toString().padLeft(4, '0')}-${firstSchedule!.month.toString().padLeft(2, '0')}-${firstSchedule!.day.toString().padLeft(2, '0')}",
        "duration": duration,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "itineraries": itineraries == null
            ? []
            : List<dynamic>.from(itineraries!.map((x) => x.toJson())),
        "location": location?.toJson(),
        "schedule": schedule == null
            ? []
            : List<dynamic>.from(schedule!.map((x) => x.toJson())),
      };
}

class Image {
  int? id;
  int? tourId;
  String? imageName;
  DateTime? createdAt;
  DateTime? updatedAt;

  Image({
    this.id,
    this.tourId,
    this.imageName,
    this.createdAt,
    this.updatedAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        tourId: json["tour_id"],
        imageName: json["image_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tour_id": tourId,
        "image_name": imageName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Itinerary {
  int? id;
  int? tourId;
  String? itineraryName;
  String? itineraryDetails;
  DateTime? createdAt;
  DateTime? updatedAt;

  Itinerary({
    this.id,
    this.tourId,
    this.itineraryName,
    this.itineraryDetails,
    this.createdAt,
    this.updatedAt,
  });

  factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
        id: json["id"],
        tourId: json["tour_id"],
        itineraryName: json["itinerary_name"],
        itineraryDetails: json["itinerary_details"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tour_id": tourId,
        "itinerary_name": itineraryName,
        "itinerary_details": itineraryDetails,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
  int? countryId;
  Country? country;

  City({
    this.id,
    this.name,
    this.countryId,
    this.country,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"],
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_id": countryId,
        "country": country?.toJson(),
      };
}

class Country {
  int? id;
  String? name;

  Country({
    this.id,
    this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Schedule {
  int? id;
  int? tourId;
  int? userId;
  DateTime? startDate;
  DateTime? endDate;
  String? duration;
  String? discount;
  DateTime? createdAt;
  DateTime? updatedAt;

  Schedule({
    this.id,
    this.tourId,
    this.userId,
    this.startDate,
    this.endDate,
    this.duration,
    this.discount,
    this.createdAt,
    this.updatedAt,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        tourId: json["tour_id"],
        userId: json["user_id"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        duration: json["duration"],
        discount: json["discount"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tour_id": tourId,
        "user_id": userId,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "duration": duration,
        "discount": discount,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
