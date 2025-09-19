enum PaymentStatus {paid,unpaid}
enum TimeStatus {onTime,overdue}

class CarSample{
  final String imgUrl;
  final String licensePlate;
  final PaymentStatus paymentStatus;
  final TimeStatus timeStatus;
  final String exitTime;
  final String exitDate;
  final String fee;

  CarSample({required this.imgUrl,required this.licensePlate,required this.paymentStatus,required this.timeStatus,
    required this.exitTime,required this.exitDate,required this.fee});
}