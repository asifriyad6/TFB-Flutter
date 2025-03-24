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
  String? profilePhoto;
  int? isActive;
  String? otp;
  dynamic createdAt;
  dynamic updatedAt;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.dob,
    this.profilePhoto,
    this.isActive,
    this.otp,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        dob: json["dob"],
        profilePhoto: json["profile_photo"],
        isActive: json["is_active"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "dob": dob,
        "profile_photo": profilePhoto,
        "is_active": isActive,
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
}
