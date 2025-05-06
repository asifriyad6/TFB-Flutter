import 'package:flutter_sslcommerz/model/SSLCEMITransactionInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:get/get.dart';

class paymentController extends GetxController {
  String? selected;
  void sslcommerz(double amount, String tranId) async {
    Sslcommerz sslcommerz = Sslcommerz(
        initializer: SSLCommerzInitialization(
            ipn_url: "https://api.travelfreak.com.bd/api/payment/ssl-ipn",
            multi_card_name: "visa,master,bkash",
            currency: SSLCurrencyType.BDT,
            product_category: "Food",
            sdkType: SSLCSdkType.TESTBOX,
            store_id: "trave5c91e88edcb51",
            store_passwd: "trave5c91e88edcb51@ssl",
            total_amount: amount,
            tran_id: tranId));
    // Sslcommerz sslcommerz = Sslcommerz(
    //     initializer: SSLCommerzInitialization(
    //         //   ipn_url: "www.ipnurl.com",
    //         currency: SSLCurrencyType.BDT,
    //         product_category: "Digital Product",
    //         sdkType: SSLCSdkType.LIVE,
    //         store_id: "travelfreakbdlive",
    //         store_passwd: "5CAD9C822AE3510248",
    //         total_amount: amount,
    //         tran_id: tranId));
    // sslcommerz.addEMITransactionInitializer(
    //     sslcemiTransactionInitializer:
    //         SSLCEMITransactionInitializer(emi_options: 1));
    final response = await sslcommerz.payNow();
    print(response.status);
    if (response.status == 'VALID') {
      Get.offNamed('/paymentSuccess');
    } else if (response.status == 'CANCELLED') {
      Get.back();
    } else if (response.status == 'FAILED') {
      Get.offNamed('/paymentFailed');
    }
  }
}
