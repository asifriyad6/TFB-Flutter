import 'config.dart';

class ApiEndpoints {
  static const String apiUrl = '${AppConfig.baseUrl}/api/v1';
  static String searchDestination = '$apiUrl/search-destination';
  static Uri bannerImages = Uri.parse('$apiUrl/banner-images');
  static Uri locationList = Uri.parse('$apiUrl/locations');
  static Uri houseboatList = Uri.parse('$apiUrl/houseboats');
  static String houseboatByLocation = '$apiUrl/houseboats/location';
  static Uri tourList = Uri.parse('$apiUrl/tours');
  static String tourByLocation = '$apiUrl/tours/location';
  static String houseboatDetails = '$apiUrl/houseboats';
  static String tourDetails = '$apiUrl/tours';
  static Uri houseboatCabins = Uri.parse('$apiUrl/houseboat-cabins');
  static Uri houseboatBooking = Uri.parse('$apiUrl/houseboat-booking');
  static Uri bookingList = Uri.parse('$apiUrl/bookings-all');
  static Uri login = Uri.parse('$apiUrl/login');
  static Uri sendOtpRegister = Uri.parse('$apiUrl/register-sendotp');
  static Uri verifyOtp = Uri.parse('$apiUrl/register-verifyotp');
  static Uri sendOtpPssReset = Uri.parse('$apiUrl/forgetpass-sendotp');
  static Uri verifyOtpPassReset = Uri.parse('$apiUrl/forgetpass-verifyotp');
  static Uri register = Uri.parse('$apiUrl/register');
  static Uri updateProfile = Uri.parse('$apiUrl/update-profile');
  static Uri changePassword = Uri.parse('$apiUrl/change-password');
  static Uri profilePictureUpload = Uri.parse('$apiUrl/upload-profile-photo');
  static Uri logout = Uri.parse('$apiUrl/logout');
  static Uri tourBooking = Uri.parse('$apiUrl/tour-booking');
  static Uri addToWishlist = Uri.parse('$apiUrl/wishlist/add');
  static Uri checkWishlist = Uri.parse('$apiUrl/wishlist/check');
  static Uri removeWishlist = Uri.parse('$apiUrl/wishlist/remove');
  static Uri getWishlist = Uri.parse('$apiUrl/wishlist');

  static Uri houseboatRoomList = Uri.parse('$apiUrl/houseboat-room-suggestion');
}
