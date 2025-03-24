class TourBookingRequest {
  int? tourId;
  String? schedule;
  double? totalAmount;
  double? payableAmount;
  double? amountPaid;
  double? amountDue;
  int? adults;
  int? children;
  TourBookingRequest({
    this.tourId,
    this.schedule,
    this.totalAmount,
    this.payableAmount,
    this.amountPaid,
    this.amountDue,
    this.adults,
    this.children,
  });
  Map<String, dynamic> toJson() {
    return {
      'tour_id': tourId,
      'schedule': schedule,
      'total_amount': totalAmount,
      'payable_amount': payableAmount,
      'amount_paid': amountPaid,
      'amount_due': amountDue,
      'adults': adults,
      'children': children,
    };
  }
}
