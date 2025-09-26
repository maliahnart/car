import 'package:car/models/parking_lot.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ParkingLotService {
  final Dio _dio = Dio(BaseOptions(baseUrl: dotenv.env['API_BASE_URL']!));

  Future<List<ParkingLot>> getParkingLots(String keyword, String token) async {
    try {
      final response = await _dio.get(
        "road/get-lots",
        queryParameters: {"keyword": keyword},
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      final data = response.data['data']['list'] as List;
      final lots = data.map((json) => ParkingLot.fromJson(json)).toList();
      print("📩 Response data: ${response.data}");
      print(lots);
      print("✅ Parsed ${lots.length} parking lots");
      return lots;
    } on DioException catch (e) {
      print("Status: ${e.response?.statusCode}");
      print("Data: ${e.response?.data}");
      print("Message: ${e.message}");
      return [];
    } catch (e) {
      return [];
    }
  }

}
