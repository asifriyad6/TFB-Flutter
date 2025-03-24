import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:get/get.dart';

class PaymentHelper extends GetxController {
  RxString selected = ''.obs;

  void onButtonTap(double amount, String tranId) async {
    switch (selected.value) {
      case 'sslcommerz':
        print('SSLCOMMERZ');
        sslcommerz(amount, tranId);
        break;
      default:
        print('No gateway selected');
    }
  }

  /// SslCommerz
  void sslcommerz(double amount, String tranId) async {
    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        multi_card_name: "visa,master,bkash",
        currency: SSLCurrencyType.BDT,
        product_category: "Digital Product",
        sdkType: SSLCSdkType.TESTBOX,
        store_id: "asifi67bb665220063",
        store_passwd: "asifi67bb665220063@ssl",
        total_amount: amount,
        tran_id: tranId,
      ),
    );

    final response = await sslcommerz.payNow();

    if (response.status == 'VALID') {
      Get.offNamed('/paymentSuccess');

      print('Payment completed, TRX ID: ${response.tranId}');
    }

    if (response.status == 'Closed') {
      Get.offNamed('/paymentFailed');
    }

    if (response.status == 'FAILED') {
      Get.offNamed('/paymentFailed');
    }
  }
}
