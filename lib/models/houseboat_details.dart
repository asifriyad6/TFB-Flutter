import 'dart:convert';

HouseboatDetails houseboatDetailsFromJson(String str) =>
    HouseboatDetails.fromJson(json.decode(str));

String houseboatDetailsToJson(HouseboatDetails data) =>
    json.encode(data.toJson());

class HouseboatDetails {
  int? id;
  int? locationId;
  int? userId;
  String? title;
  String? slug;
  String? description;
  String? highlights;
  String? visibleSpots;
  int? capacity;
  int? totalRooms;
  String? includes;
  String? excludes;
  String? thumbnail;
  int? status;
  int? featured;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? startingPrice;
  String? discountedPrice;
  List<Image>? images;
  Location? location;
  List<Schedule>? schedule;

  HouseboatDetails({
    this.id,
    this.locationId,
    this.userId,
    this.title,
    this.slug,
    this.description,
    this.highlights,
    this.visibleSpots,
    this.capacity,
    this.totalRooms,
    this.includes,
    this.excludes,
    this.thumbnail,
    this.status,
    this.featured,
    this.createdAt,
    this.updatedAt,
    this.startingPrice,
    this.discountedPrice,
    this.images,
    this.location,
    this.schedule,
  });

  factory HouseboatDetails.fromJson(Map<String, dynamic> json) =>
      HouseboatDetails(
        id: json["id"],
        locationId: json["location_id"],
        userId: json["user_id"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        highlights: json["highlights"],
        visibleSpots: json["visible_spots"],
        capacity: json["capacity"],
        totalRooms: json["total_rooms"],
        includes: json["includes"],
        excludes: json["excludes"],
        thumbnail: json["thumbnail"],
        status: json["status"],
        featured: json["featured"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        startingPrice: json["starting_price"],
        discountedPrice: json["discounted_price"],
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
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
        "capacity": capacity,
        "total_rooms": totalRooms,
        "includes": includes,
        "excludes": excludes,
        "thumbnail": thumbnail,
        "status": status,
        "featured": featured,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "starting_price": startingPrice,
        "discounted_price": discountedPrice,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "location": location?.toJson(),
        "schedule": schedule == null
            ? []
            : List<dynamic>.from(schedule!.map((x) => x.toJson())),
      };
}

class Image {
  int? id;
  int? houseboatId;
  String? imageName;
  DateTime? createdAt;
  DateTime? updatedAt;

  Image({
    this.id,
    this.houseboatId,
    this.imageName,
    this.createdAt,
    this.updatedAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        houseboatId: json["houseboat_id"],
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
        "houseboat_id": houseboatId,
        "image_name": imageName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Location {
  int? id;
  int? cityId;
  int? countryId;
  String? slug;
  String? name;
  String? thumbnail;
  DateTime? createdAt;
  DateTime? updatedAt;

  Location({
    this.id,
    this.cityId,
    this.countryId,
    this.slug,
    this.name,
    this.thumbnail,
    this.createdAt,
    this.updatedAt,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
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
      };
}

class Schedule {
  int? id;
  int? houseboatId;
  int? userId;
  DateTime? startDate;
  DateTime? endDate;
  String? duration;
  DateTime? createdAt;
  DateTime? updatedAt;

  Schedule({
    this.id,
    this.houseboatId,
    this.userId,
    this.startDate,
    this.endDate,
    this.duration,
    this.createdAt,
    this.updatedAt,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        houseboatId: json["houseboat_id"],
        userId: json["user_id"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        duration: json["duration"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "houseboat_id": houseboatId,
        "user_id": userId,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "duration": duration,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
