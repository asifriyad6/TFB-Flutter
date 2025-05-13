import 'dart:io';

class AppConfig {
  static const String appName = 'Travel Freak BD';
  static const String baseUrl = 'http://10.0.2.2:8000';
  //static const String baseUrl = 'https://api.travelfreak.com.bd';
  static const String bannerImage = '$baseUrl/images/banner';
  static const String locationImage = '$baseUrl/images/locations';
  static const String houseboatImage = '$baseUrl/images/houseboat';
  static const String tourImage = '$baseUrl/images/tours';
  static const String profileImage = '$baseUrl/images/customer';
}

String getAppPlatform() {
  if (Platform.isAndroid) return 'flutter-android';
  if (Platform.isIOS) return 'flutter-ios';
  return 'flutter-unknown';
}
