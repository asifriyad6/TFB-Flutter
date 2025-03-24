import 'package:tfb/models/Houseboat/cabin_details.dart';

class HouseboatBookingRequest {
  int? houseboatId;
  String? schedule;
  double? totalAmount;
  double? payableAmount;
  double? amountPaid;
  double? amountDue;
  List<CabinSelection>? cabins;

  HouseboatBookingRequest({
    this.houseboatId,
    this.schedule,
    this.totalAmount,
    this.payableAmount,
    this.amountPaid,
    this.amountDue,
    this.cabins,
  });
  Map<String, dynamic> toJson() {
    return {
      'houseboat_id': houseboatId,
      'schedule': schedule,
      'total_amount': totalAmount,
      'payable_amount': payableAmount,
      'amount_paid': amountPaid,
      'amount_due': amountDue,
      'cabins': cabins?.map((cabin) => cabin.toJson()).toList(),
    };
  }
}
