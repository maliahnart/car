// // models/price_shift.dart
// class PriceShift {
//   final String refCarName;
//   final double dayPrice;
//   final double nightPrice;
//   final double allDayPrice;

//   PriceShift({
//     required this.refCarName,
//     required this.dayPrice,
//     required this.nightPrice,
//     required this.allDayPrice,
//   });

//   factory PriceShift.fromJson(Map<String, dynamic> json) {
//     final price = (json['price'] ?? 0).toDouble(); // fallback nếu chỉ có 'price'
//     return PriceShift(
//       refCarName: json['refCarName'] ?? '',
//       dayPrice: (json['dayPrice'] ?? price).toDouble(),
//       nightPrice: (json['nightPrice'] ?? price).toDouble(),
//       allDayPrice: (json['allDayPrice'] ?? price).toDouble(),
//     );
//   }
// }
// models/price_shift.dart
class PriceShift {
  final int id;
  final String refCarName;
  final int refCarType;
  final double dayPrice;
  final double nightPrice;
  final double allDayPrice;
  final bool isBlock; 
  PriceShift({
    required this.id,
    required this.refCarName,
    required this.refCarType,
    required this.dayPrice,
    required this.nightPrice,
    required this.allDayPrice,
    required this.isBlock,
  });

  factory PriceShift.fromJson(Map<String, dynamic> json) {
    final price = (json['price'] ?? 0).toDouble();
    final isBlock = json.containsKey('price');

    return PriceShift(
      id: json['id'],
      refCarType: json['refCarType'],
      refCarName: json['refCarName'] ?? '',
      dayPrice: (json['dayPrice'] ?? price).toDouble(),
      nightPrice: (json['nightPrice'] ?? price).toDouble(),
      allDayPrice: (json['allDayPrice'] ?? price).toDouble(),
      isBlock: isBlock,
    );
  }
}
