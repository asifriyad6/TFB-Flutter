import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:tfb/utils/endpoints.dart';
import 'package:tfb/views/AuthScreen/otp_verify.dart';
import 'package:tfb/views/AuthScreen/save_customer.dart';
import '../Helpers/token_helper.dart';
import '../utils/config.dart';

import '../models/user_model.dart';
import '../services/api_services.dart';
import '../services/shared_services.dart';

class AuthController extends GetxController {
  final RxBool loadingLogin = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool passView = true.obs;
  final RxBool passViewConfirm = true.obs;
  final RxBool isAuthenticated = false.obs;
  var userModel = UserModel().obs;
  RxString confirmPassword = ''.obs;
  var passLengthValid = false.obs;
  var passHasLetter = false.obs;
  var passHasNumber = false.obs;
  var hasSpecialChar = false.obs;
  var hasUpperCase = false.obs;
  var hasLowerCase = false.obs;
  final RegExp _passwordRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  var profileImageUrl = ''.obs;
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();
  var isUploading = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkToken();
    getUserProfilePhoto();
  }

  checkToken() async {
    final token = await SharedServices.getData(SetType.string, 'token');
    if (token != null && token.isNotEmpty) {
      isAuthenticated.value = true;
    } else {
      isAuthenticated.value = false;
    }
    final userJson = await SharedServices.getData(SetType.string, 'user');
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      userModel.value = UserModel.fromJson(userMap);
      isAuthenticated.value = true;
    }
  }

  login() async {
    try {
      if (userModel.value.phone == null || userModel.value.password == null) {
        Get.snackbar('Error', 'Please provide valid credentials');
        return;
      }
      loadingLogin.value = true;
      final response = await ApiServices.login(userModel.value);
      loadingLogin.value = false;
      final decode = jsonDecode(response.body);
      if (response.statusCode != 200) {
        Get.snackbar('Error', decode['message']);
        return;
      }
      await SharedServices.setData(SetType.string, 'token', decode['token']);
      await SharedServices.setData(
          SetType.string, 'user', jsonEncode(decode['data']));
      userModel.value = UserModel.fromJson(decode['data']);
      profileImageUrl.value = userModel.value.profilePhoto!;
      update();
      Get.offAllNamed('/main');
    } catch (e) {
      loadingLogin.value = false;
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    }
  }

  logout() async {
    isLoading.value = true;
    final response = await ApiServices.logout();
    if (response.statusCode != 200) {
      Get.snackbar('Error', 'Internal Server Error');
      return;
    }
    await SharedServices.removeData('token');
    await SharedServices.removeData('user');
    isLoading.value = false;
    Get.offAllNamed('/main');
  }

  sendOtp() async {
    try {
      if (userModel.value.phone == '' || userModel.value.phone!.length < 11) {
        Get.snackbar('Error', 'Phone number must be 11 digit');
        return;
      }
      isLoading.value = true;
      final response =
          await ApiServices.sendOtpRegister(userModel.value.phone!);
      isLoading.value = false;
      final decode = jsonDecode(response.body);
      if (response.statusCode != 200) {
        Get.snackbar('Error', decode['message']);
        return;
      }
      Get.to(OtpVerify());
    } catch (e) {
      print(userModel.value.phone);
      isLoading.value = false;
      print(e);
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    }
  }

  verifyOtp() async {
    try {
      if (userModel.value.phone == null || userModel.value.otp == null) {
        Get.snackbar('Error', 'Enter OTP Code');
        return;
      }
      isLoading.value = true;
      final response = await ApiServices.verifyOtp(userModel.value);
      isLoading.value = false;
      final decode = jsonDecode(response.body);
      if (response.statusCode != 200) {
        Get.snackbar('Error', decode['message']);
        return;
      }
      Get.to(SaveCustomer());
    } catch (e) {
      loadingLogin.value = false;
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    }
  }

  void validatePassword(String value) {
    userModel.value.password = value;
    passLengthValid.value = value.length >= 8;
    passHasLetter.value = value.contains(RegExp(r'[A-Za-z]'));
    passHasNumber.value = value.contains(RegExp(r'[0-9]'));
  }
  // void validatePassword(String password) {
  //   passLengthValid.value = password.length >= 8;
  //   hasUpperCase.value = password.contains(RegExp(r'[A-Z]'));
  //   hasLowerCase.value = password.contains(RegExp(r'[a-z]'));
  //   passHasNumber.value = password.contains(RegExp(r'[0-9]'));
  //   hasSpecialChar.value = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  // }

  bool isPasswordValid() {
    return passLengthValid.value && passHasLetter.value && passHasNumber.value;
  }

  bool isPasswordMatch() {
    return confirmPassword.value == userModel.value.password;
  }

  register() async {
    try {
      if (userModel.value.name == null || userModel.value.password == null) {
        Get.snackbar('Error', 'Please provide all required data');
        return;
      }
      isLoading.value = true;
      final response = await ApiServices.register(userModel.value);
      isLoading.value = false;
      final decode = jsonDecode(response.body);
      if (response.statusCode != 200) {
        Get.snackbar('Error', decode['message']);
        return;
      }
      await SharedServices.setData(SetType.string, 'token', decode['token']);
      await SharedServices.setData(
          SetType.string, 'user', jsonEncode(decode['data']));
      userModel.value = UserModel.fromJson(decode['data']);
      update();
      Get.offAllNamed('/main');
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      uploadImage(selectedImage!);
    }
  }

  Future<void> uploadImage(File imageFile) async {
    isUploading(true);
    var uri = Uri.parse("${ApiEndpoints.profilePictureUpload}");
    var request = http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = await authToken();

    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var multipartFile = http.MultipartFile('profile_picture', stream, length,
        filename: basename(imageFile.path));

    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      response.stream.transform(utf8.decoder).listen((value) {
        var jsonResponse = json.decode(value);
        profileImageUrl.value =
            jsonResponse['profile_picture_url']; // Update avatar
      });
    } else {
      print("Upload failed: ${response.reasonPhrase}");
    }
    isUploading(false);
  }

  Future<String?> getUserProfilePhoto() async {
    String? userDataString =
        await SharedServices.getData(SetType.string, 'user');

    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);

      // Assuming the profile photo is stored under the key 'profile_photo'
      //return userData['profile_photo'];
      profileImageUrl.value = userData['profile_photo'];
    }
    return null; // Return null if user data is not found
  }
}
