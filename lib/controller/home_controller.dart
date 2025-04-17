import 'package:get/get.dart';
import 'package:tfb/models/Tour/tour_model.dart';
import 'package:tfb/models/banner_images.dart';
import 'package:tfb/models/houseboat_model.dart';
import 'package:tfb/models/location_model.dart';
import 'package:tfb/services/api_services.dart';

class HomeController extends GetxController {
  var houseboats = <HouseboatModel>[].obs;
  var banner = <BannerImages>[].obs;
  var locations = <LocationModel>[].obs;
  var tours = <TourModel>[].obs;
  RxBool isLoading = RxBool(false);
  RxBool tourLoading = RxBool(false);
  RxBool locationLoading = RxBool(false);
  RxBool carouselLoading = RxBool(false);

  @override
  onInit() {
    super.onInit();
    getBanner();
    getLocation();
    getHouseboat();
    getTour();
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

  Future<void> refreshPage() async {
    await getHouseboat();
    await getTour();
  }
}
