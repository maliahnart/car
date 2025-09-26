import 'package:car/models/price_shift.dart';

class ParkingLot {
  final int id;
  final String name;
  final String addrDetail;
  final String? phoneNumber;
  final int lotNumber;
  final String parkingCode;
  final int refParkingType;
  // final List<PriceShift> priceShifts; 

  const ParkingLot({
    required this.id,
    required this.name,
    required this.addrDetail,
    this.phoneNumber,
    required this.lotNumber,
    required this.parkingCode,
    required this.refParkingType
    // this.priceShifts = const [],
  });

  factory ParkingLot.fromJson(Map<String, dynamic> json) {
    return ParkingLot(
      id: json['id'],
      name: json['name'] ?? '',
      addrDetail: json['addrDetail'] ?? '',
      phoneNumber: json['phoneNumber'],
      lotNumber: json['lotNumber'] ?? 0,
      parkingCode: json['code'] ?? '',
      refParkingType: json['refParkingType']
      // priceShifts: (json['priceShift'] as List<dynamic>?)
      //         ?.map((e) => PriceShift.fromJson(e))
      //         .toList() ??
      //     [],
    );
  }
}
