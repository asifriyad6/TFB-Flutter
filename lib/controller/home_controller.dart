import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tfb/models/Tour/tour_model.dart';
import 'package:tfb/models/banner_images.dart';
import 'package:tfb/models/general_settings.dart';
import 'package:tfb/models/houseboat_model.dart';
import 'package:tfb/models/location_model.dart';
import 'package:tfb/services/api_services.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  var houseboats = <HouseboatModel>[].obs;
  var banner = <BannerImages>[].obs;
  var locations = <LocationModel>[].obs;
  var tours = <TourModel>[].obs;
  var generalSettings = GeneralSettings().obs;
  RxBool isLoading = RxBool(false);
  RxBool tourLoading = RxBool(false);
  RxBool locationLoading = RxBool(false);
  RxBool carouselLoading = RxBool(false);
  RxBool isUpdateRequired = RxBool(false);
  RxBool isChecking = RxBool(true);

  @override
  onInit() async {
    super.onInit();
    await getGeneralData();
    await checkVersion();
    getBanner();
    storeFcmTokens();
    getLocation();
    getHouseboat();
    getTour();
  }

  getGeneralData() async {
    final response = await ApiServices.getGeneralSettings();
    if (response.statusCode == 200) {
      generalSettings.value = generalSettingsFromJson(response.body);
      update();
    } else {
      Get.snackbar('Error', response.body);
    }
  }

  Future<void> checkVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version;
      String latestVersion = generalSettings.value.androidVersion!;
      if (latestVersion != currentVersion) {
        isUpdateRequired.value = true;
      }
    } catch (e) {
      print("Version check error: $e");
    } finally {
      isChecking.value = false;
    }
  }

  void launchUpdateUrl() async {
    final url = Uri.parse(generalSettings.value.androidUrl!);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar("Error", "Could not launch update link");
    }
  }

  Future<void> launchPhone() async {
    final Uri url = Uri(scheme: 'tel', path: generalSettings.value.phone1);
    try {
      if (!await launchUrl(url)) {
        throw 'Could not launch phone dialer';
      }
    } catch (e) {
      print('Error launching phone: $e');
    }
  }

  Future<void> launchEmail() async {
    final Uri url = Uri(scheme: 'mailto', path: generalSettings.value.email);
    if (await canLaunchUrl(url)) {
      final success =
          await launchUrl(url, mode: LaunchMode.externalApplication);
      if (!success) {
        Get.snackbar('Error', 'Could not launch the URL');
      }
    } else {
      Get.snackbar('Error', 'Could not open email app');
    }
  }

  openSocialUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      final success =
          await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!success) {
        Get.snackbar('Error', 'Could not launch the URL');
      }
    } else {
      Get.snackbar('Error', 'Invalid URL');
    }
  }

  getBanner() async {
    carouselLoading.value = true;
    final response = await ApiServices.getBanner();
    if (response.statusCode == 200) {
      banner.value = bannerImagesFromJson(response.body);
      carouselLoading.value = false;
      update();
    } else {
      Get.snackbar('Error', 'Internal Server Error');
    }
  }

  getLocation() async {
    locationLoading.value = true;
    final response = await ApiServices.getLocation();
    if (response.statusCode == 200) {
      locations.value = locationModelFromJson(response.body);
      locationLoading.value = false;
      update();
    } else {
      Get.snackbar('Error', 'Internal Server Error');
    }
  }

  getHouseboat() async {
    isLoading.value = true;
    final response = await ApiServices.getHouseboat();
    if (response.statusCode == 200) {
      isLoading.value = false;
      houseboats.value = houseboatModelFromJson(response.body);
      update();
    } else {
      isLoading.value = false;
      Get.snackbar('Error', 'Internal Server Error');
    }
  }

  getTour() async {
    tourLoading.value = true;
    final response = await ApiServices.getTour();
    if (response.statusCode == 200) {
      tourLoading.value = false;
      tours.value = tourModelFromJson(response.body);
      update();
    } else {
      tourLoading.value = false;
      Get.snackbar('Error', 'Internal Server Error');
    }
  }

  storeFcmTokens() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      final deviceId = androidInfo.id;
      final deviceName = androidInfo.model;
      final deviceManufacturer = androidInfo.manufacturer;
      final deviceBrand = androidInfo.brand;
      final deviceVersion = androidInfo.version.release;
      await ApiServices.saveFcmTokenToServer(fcmToken, deviceId, deviceName,
          deviceManufacturer, deviceBrand, deviceVersion);
    }
  }

  Future<void> refreshPage() async {
    await getHouseboat();
    await getTour();
  }
}
