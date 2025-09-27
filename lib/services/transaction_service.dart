import 'dart:io';
import 'package:camera/camera.dart';
import 'package:car/models/transaction_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TransactionService {
  final Dio _dio = Dio(BaseOptions(baseUrl: dotenv.env['API_BASE_URL']!));

  Future<void> checkIn({
    required int lotId,
    required String parkingCode,
    required int amount,
    required String paymentType,
    required int refCarTypeId,
    required int? blockNum,
    required String plateNumber,
    required int? shiftType,
    required XFile? imageFile,
    required String? token,
  }) async {
    try {
      final formData = FormData.fromMap({
        "lotId": lotId.toString(),
        "parkingCode": parkingCode,
        "amount": amount.toString(),
        "paymentType": paymentType,
        "refCarTypeId": refCarTypeId.toString(),
        "blockNum": blockNum.toString(),
        "plateNumber": plateNumber,
        "shiftType": shiftType.toString(),
        if (imageFile != null)
          "image": await MultipartFile.fromFile(
            imageFile.path,
            filename: "parking_image.jpg",
          ),
      });

      final response = await _dio.post(
        'road/check-in',
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      print("✅ Check-in response: ${response.data}");
      print(response.requestOptions.data);

      if (response.data['status'] == 400) {
        print("❌ Lỗi: ${response.data['errorDesc']}");
      }
    } on DioException catch (e) {
      print("❌ Dio error: ${e.response?.statusCode} ${e.response?.data}");
    
    }
  }
   Future<TransactionPage> searchTransactions({ 
    required int lotId,
    required int? parkingStatus,
    String? plateNumber,
    int? transactionStatus,
    String? expiredParking,
    int page = 0,
    int size = 10,
    required String token,
  }) async {
    try {
      final response = await _dio.get(
        'road/search-transaction',
        queryParameters: {
          'refLotId': lotId,
        if (parkingStatus != null) 'parkingStatus': parkingStatus,
          'plateNumber': plateNumber ?? '',
          if (transactionStatus != null) 'transactionStatus': transactionStatus,
          if (expiredParking != null) 'expiredParking': expiredParking,
          'page': page,
          'size': size,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );


      if (response.statusCode == 200 && response.data['status'] == 200) {
        print("👉 API gọi đến: ${response.requestOptions.uri}");
        return TransactionPage.fromJson(response.data['data'] as Map<String, dynamic>);
      } else {
        final errorMessage = response.data['errorDesc'] ?? 'Failed to load transactions';
        throw Exception(errorMessage);
      }
    } on DioException catch (e) {
      print("❌ Dio error while searching transactions: ${e.response?.statusCode} ${e.response?.data}");
      throw Exception('Error searching transactions: ${e.message}');
    }
  }
}
