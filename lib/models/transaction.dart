
class Transaction {
  final String plateNumber;
  final int transactionStatus; 
  final String paymentType;
  final String expiredParking; 
  final DateTime estimateCheckOutTime;
  final int amount;
  final String parkingId; 
  final String pathImg;

  Transaction({
    required this.plateNumber,
    required this.transactionStatus,
    required this.paymentType,
    required this.expiredParking,
    required this.estimateCheckOutTime,
    required this.amount,
    required this.parkingId,
    required this.pathImg,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      plateNumber: json['plateNumber'] as String,
      transactionStatus: json['transactionStatus'] as int,
      paymentType: json['paymentType'] as String,
      expiredParking: json['expiredParking'] as String,
      estimateCheckOutTime: DateTime.parse(json['estimateCheckOutTime'] as String),
      amount: json['amount'] as int,
      parkingId: json['parkingId'] as String,
      pathImg: json['pathImg'] as String,
    );
  }
}