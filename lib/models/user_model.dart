import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? dob;
  String? profession;
  String? profilePhoto;
  String? address;
  String? city;
  int? isActive;
  String? otp;
  double? points;
  dynamic createdAt;
  dynamic updatedAt;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.dob,
    this.profession,
    this.profilePhoto,
    this.address,
    this.city,
    this.isActive,
    this.otp,
    this.points,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        dob: json["dob"],
        profession: json["profession"],
        profilePhoto: json["profile_photo"],
        address: json["address"],
        city: json["city"],
        isActive: json["is_active"],
        points: json["points"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "dob": dob,
        "profession": profession,
        "profile_photo": profilePhoto,
        "address": address,
        "city": city,
        "is_active": isActive,
        "points": points,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  Map<String, dynamic> toLogin() {
    return {
      'password': password,
      'phone': phone,
    };
  }

  Map<String, dynamic> verifyOtp() {
    return {
      'phone': phone,
      'otp': otp,
    };
  }

  Map<String, dynamic> toRegister() {
    return {
      'name': name,
      'phone': phone,
      'password': password,
    };
  }

  Map<String, dynamic> updateProfile() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'dob': dob,
      'profession': profession,
      'address': address,
      'city': city,
    };
  }

  Map<String, dynamic> changePassword() {
    return {
      'phone': phone,
      'password': password,
    };
  }
}
