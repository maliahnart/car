// // services/price_shift_service.dart
// import 'package:car/models/price_shift.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// class PriceShiftService {
//   final Dio _dio = Dio(BaseOptions(baseUrl: dotenv.env['API_BASE_URL']!));

//   Future<List<PriceShift>> getPriceShiftsOfLot(int lotID, String token) async {
//     try {
//       final response = await _dio.get(
//         "road/get-detail-lots/$lotID",
//         options: Options(headers: {"Authorization": "Bearer $token"}),
//       );

//       final data = response.data['data'] as Map<String, dynamic>?;

//       if (data == null) {
//         print("⚠️ Không có dữ liệu cho lotID $lotID");
//         return [];
//       }

//       final priceShiftData = data['priceShift'] as List<dynamic>? ?? [];
//       final priceBlockData = data['priceBlocks'] as List<dynamic>? ?? [];

//       final priceShifts = <PriceShift>[];
//       priceShifts.addAll(
//         priceShiftData.map((json) => PriceShift.fromJson(json as Map<String, dynamic>))
//       );
//       priceShifts.addAll(
//         priceBlockData.map((json) => PriceShift.fromJson(json as Map<String, dynamic>))
//       );

//       print("✅ Parsed ${priceShifts.length} price shifts for lotID $lotID");
//       priceShifts.forEach((p) => print("🔹 ${p.refCarName} - ${p.dayPrice}"));

//       return priceShifts;
//     } catch (e) {
//       print("Error fetching price shifts for lotID $lotID: $e");
//       return [];
//     }
//   }
// }
// services/price_shift_service.dart
import 'package:car/models/price_shift.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PriceShiftService {
  final Dio _dio = Dio(BaseOptions(baseUrl: dotenv.env['API_BASE_URL']!));

  Future<List<PriceShift>> getPriceShiftsOfLot(int lotID, String token) async {
    try {
      final response = await _dio.get(
        "road/get-detail-lots/$lotID",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      final data = response.data['data'] as Map<String, dynamic>?;

      if (data == null) {
        print("⚠️ Không có dữ liệu cho lotID $lotID");
        return [];
      }

      final priceShiftData = (data['priceShift'] as List<dynamic>? ?? [])
          .map((json) => PriceShift.fromJson(json as Map<String, dynamic>));
      final priceBlockData = (data['priceBlocks'] as List<dynamic>? ?? [])
          .map((json) => PriceShift.fromJson(json as Map<String, dynamic>));

      final priceShifts = [...priceShiftData, ...priceBlockData];

      print("✅ Parsed ${priceShifts.length} price shifts for lotID $lotID");
      for (final p in priceShifts) {
        if (p.isBlock) {
          print("🔹 ${p.refCarName} (Block) - Giá: ${p.dayPrice}");
        } else {
          print("🔹 ${p.refCarName} (Shift) - Ngày: ${p.dayPrice}, Đêm: ${p.nightPrice}");
        }
      }

      return priceShifts;
    } catch (e, stack) {
      print("❌ Error fetching price shifts for lotID $lotID: $e");
      print(stack);
      return [];
    }
  }
}
