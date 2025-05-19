import 'dart:convert';

GeneralSettings generalSettingsFromJson(String str) =>
    GeneralSettings.fromJson(json.decode(str));

String generalSettingsToJson(GeneralSettings data) =>
    json.encode(data.toJson());

class GeneralSettings {
  int? id;
  String? company;
  dynamic tagline;
  String? logo;
  String? topBanner;
  String? aboutUs;
  String? termsConditions;
  String? privacyPolicy;
  String? refundPolicy;
  String? phone1;
  String? phone2;
  String? email;
  String? address;
  dynamic latitude;
  dynamic longitude;
  String? androidVersion;
  String? iosVersion;
  String? androidUrl;
  String? iosUrl;
  String? facebook;
  String? instagram;
  String? whatsapp;
  String? linkedin;
  String? youtube;

  GeneralSettings({
    this.id,
    this.company,
    this.tagline,
    this.logo,
    this.topBanner,
    this.aboutUs,
    this.termsConditions,
    this.privacyPolicy,
    this.refundPolicy,
    this.phone1,
    this.phone2,
    this.email,
    this.address,
    this.latitude,
    this.longitude,
    this.androidVersion,
    this.iosVersion,
    this.androidUrl,
    this.iosUrl,
    this.facebook,
    this.instagram,
    this.whatsapp,
    this.linkedin,
    this.youtube,
  });

  factory GeneralSettings.fromJson(Map<String, dynamic> json) =>
      GeneralSettings(
        id: json["id"],
        company: json["company"],
        tagline: json["tagline"],
        logo: json["logo"],
        topBanner: json["top_banner"],
        aboutUs: json["about_us"],
        termsConditions: json["terms_conditions"],
        privacyPolicy: json["privacy_policy"],
        refundPolicy: json["refund_policy"],
        phone1: json["phone_1"],
        phone2: json["phone_2"],
        email: json["email"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        androidVersion: json["android_version"],
        iosVersion: json["ios_version"],
        androidUrl: json["android_url"],
        iosUrl: json["ios_url"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        whatsapp: json["whatsapp"],
        linkedin: json["linkedin"],
        youtube: json["youtube"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company": company,
        "tagline": tagline,
        "logo": logo,
        "top_banner": topBanner,
        "about_us": aboutUs,
        "terms_conditions": termsConditions,
        "privacy_policy": privacyPolicy,
        "refund_policy": refundPolicy,
        "phone_1": phone1,
        "phone_2": phone2,
        "email": email,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "android_version": androidVersion,
        "ios_version": iosVersion,
        "android_url": androidUrl,
        "ios_url": iosUrl,
        "facebook": facebook,
        "instagram": instagram,
        "whatsapp": whatsapp,
        "linkedin": linkedin,
        "youtube": youtube,
      };
}
