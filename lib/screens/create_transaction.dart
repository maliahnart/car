import 'dart:io';

import 'package:camera/camera.dart';
import 'package:car/config/state/parking_lot_bloc.dart';
import 'package:car/config/token_storage.dart';
import 'package:car/models/parking_lot.dart';
import 'package:car/models/price_shift.dart';
import 'package:car/services/parking_lots_info_service.dart';
import 'package:car/services/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateTransaction extends StatefulWidget {
  final XFile? capturedImage;
  const CreateTransaction({
    super.key,
    this.capturedImage,
  });

  @override
  State<CreateTransaction> createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  bool _isLoadingVehicleTypes = true;
  int? _selectedVehicleTypeIndex;
  int? _selectedHourIndex;
  ParkingLot? _selectedLot;
  int _selectedPaymentMethodIndex = 0;
  List<PriceShift> _vehicleTypes = [];
  String? _error;
  final _plateNumberController = TextEditingController();

  // Mock data for choices
  // final List<Map<String, String>> _vehicleTypes = [
  //   {'name': 'Ô tô con', 'price': '15.000đ/h'},
  //   {'name': 'Ô tô tải', 'price': '20.000đ/h'},
  //   {'name': 'Xe van', 'price': '25.000đ/h'},
  //   {'name': 'Ô tô tải', 'price': '35.000đ/h'},
  // ];

  final List<Map<String, dynamic>> _paymentMethods = [
    {'name': 'Điện tử', 'icon': Icons.smartphone},
    {'name': 'Tiền mặt', 'icon': Icons.monetization_on_outlined},
  ];
 @override
  void initState() {
    super.initState();
    _selectedLot = context.read<ParkingLotBloc>().state.selectedParkingLot;

    if (_selectedLot != null) {
      _fetchPriceShiftsForSelectedLot();
    } else {
      setState(() {
        _error = 'Lỗi: Không tìm thấy thông tin bãi đỗ.';
        _isLoadingVehicleTypes = false;
      });
    }

    _initParkingHour();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _plateNumberController.dispose();
    super.dispose();
  }

  String _calculateFeeDisplay() {
    if (_selectedVehicleTypeIndex == null || _selectedHourIndex == null) {
      return '0đ';
    }
    final selectedVehicle = _vehicleTypes[_selectedVehicleTypeIndex!];
    final price = selectedVehicle.dayPrice * _selectedHourIndex!;
    final priceFormatter = NumberFormat.decimalPattern('vi_VN');
    return '${priceFormatter.format(price)}đ';
  }

  int _calculateFeeAmount() {
    if (_selectedVehicleTypeIndex == null || _selectedHourIndex == null) {
      return 0;
    }
    final selectedVehicle = _vehicleTypes[_selectedVehicleTypeIndex!];
    return selectedVehicle.dayPrice.toInt() * _selectedHourIndex!;
  }

  Future<void> _fetchPriceShiftsForSelectedLot() async {
    try {
      final token = await TokenStorage.getToken();
      if (token == null) throw Exception("Không tìm thấy token.");

      final service = PriceShiftService();
      final priceShifts = await service.getPriceShiftsOfLot(
        _selectedLot!.id,
        token,
      );


      if (mounted) {
        if (priceShifts.isNotEmpty) {
          setState(() {
            _vehicleTypes = priceShifts;
            _isLoadingVehicleTypes = false;
            _error = null;
          });
        } else {
          setState(() {
            _error = 'Không có thông tin giá cho bãi đỗ này.';
            _isLoadingVehicleTypes = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Lỗi khi tải dữ liệu giá xe.';
          _isLoadingVehicleTypes = false;
        });
      }
    }
  }

  Future<void> _initParkingHour() async {
    if (widget.capturedImage != null) {
      final hour = await getCapturedHour(File(widget.capturedImage!.path));
    }
  }

  Future<int> getCapturedHour(File imageFile) async {
    final modified = await imageFile.lastModified();
    return modified.hour;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          centerTitle: true,
          toolbarHeight: 70,
          title: Text(
            'Tạo giao dịch',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(-14326805), Color(-14856488)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                _buildCarImage(),
                const SizedBox(height: 24),
                _buildSectionCard(
                  title: 'Thông tin xe',
                  icon: 'assets/images/car_green.png',
                  iconColor: Color(0xff22C55E),
                  child: _buildVehicleInfoSection(),
                ),
                const SizedBox(height: 20),
                _buildSectionCard(
                  title: 'Thời gian gửi xe',
                  icon: 'assets/images/timer_icon.png',
                  iconColor: Color(0xffF97316),
                  child: _buildParkingDurationSection(),
                ),
                const SizedBox(height: 20),
                _buildSectionCard(
                  title: 'Phương thức thanh toán',
                  icon: 'assets/images/payment_icon.png',
                  iconColor: Color(0xffA855F7),
                  child: _buildPaymentMethodSection(),
                ),
                const SizedBox(height: 10),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCarImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          widget.capturedImage != null
              ? Image.file(
                  File(widget.capturedImage!.path),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/images/full_car.png',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),

          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(128),
                borderRadius: BorderRadius.circular(8),
              ),
              child: FutureBuilder<DateTime>(
                future: File(widget.capturedImage!.path).lastModified(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const SizedBox();
                  final modifiedStr = DateFormat(
                    'dd/MM/yyyy HH:mm:ss',
                  ).format(snapshot.data!);
                  return Text(
                    modifiedStr,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String icon,
    required Color iconColor,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.1 * 255).toInt()),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(icon, color: iconColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildVehicleInfoSection() {
    // Nếu đang tải, hiển thị vòng quay
    if (_isLoadingVehicleTypes) {
      return const Center(child: CircularProgressIndicator());
    }

    // Nếu có lỗi, hiển thị thông báo lỗi
    if (_error != null) {
      return Center(
        child: Text(_error!, style: const TextStyle(color: Colors.red)),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Biển số xe', style: TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: _plateNumberController,
          decoration: InputDecoration(
            hintText: 'VD: 30A-12345',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
        const SizedBox(height: 16),
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Loại xe',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' '),
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
            style: TextStyle(color: Colors.black54),
          ),
        ),
        const SizedBox(height: 8),
        // GridView.builder(
        //   shrinkWrap: true,
        //   physics: NeverScrollableScrollPhysics(),
        //   itemCount: _vehicleTypes.length,
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     childAspectRatio: 2.5,
        //     crossAxisSpacing: 12,
        //     mainAxisSpacing: 12,
        //   ),
        //   itemBuilder: (context, index) {
        //     bool isSelected = _selectedVehicleTypeIndex == index;
        //     return GestureDetector(
        //       onTap: () => setState(() {
        //         _selectedVehicleTypeIndex = index;
        //       }),
        //       child: Container(
        //         padding: const EdgeInsets.all(8),
        //         decoration: BoxDecoration(
        //           color: isSelected ? Color(0xffEFF6FF) :  Colors.white,
        //           borderRadius: BorderRadius.circular(8),
        //           border: Border.all(color: isSelected ? Colors.blue : Colors.grey)
        //         ),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Text(
        //               _vehicleTypes[index]['name']!,
        //               style: TextStyle(fontWeight: FontWeight.bold),
        //             ),
        //             Text(
        //               _vehicleTypes[index]['price']!,
        //               style: TextStyle(color: Colors.black54, fontSize: 12),
        //             ),
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _vehicleTypes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            bool isSelected = _selectedVehicleTypeIndex == index;
            final vehicleType = _vehicleTypes[index];

            final priceFormatter = NumberFormat.decimalPattern('vi_VN');
            final formattedPrice = priceFormatter.format(vehicleType.dayPrice);

            return GestureDetector(
              onTap: () => setState(() {
                _selectedVehicleTypeIndex = index;
              }),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xffEFF6FF) : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      vehicleType.refCarName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '$formattedPrice đ/h',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildParkingDurationSection() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.blue.withAlpha((0.1 * 255).toInt()),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: Color(0xff2563EB), size: 12),
              const SizedBox(width: 4),
              Text(
                'Thời gian vào gửi xe được tự động lấy theo thời điểm chụp ảnh',
                style: TextStyle(fontSize: 9),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          itemCount: 24,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            bool isSelected = _selectedHourIndex == index + 1;
            return GestureDetector(
              onTap: () => setState(() {
                _selectedHourIndex = index + 1;
              }),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xffEFF6FF) : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey,
                  ),
                ),
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Color(0xff1D4ED8) : Colors.black,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPaymentMethodSection() {
    return Row(
      children: [
        ...List.generate(_paymentMethods.length, (index) {
          bool isSelected = _selectedPaymentMethodIndex == index;

          // Chọn màu nền theo index
          Color bgColor;
          if (index == 0) {
            bgColor = const Color(0xffDCFCE7); // xanh nhạt
          } else if (index == 1) {
            bgColor = const Color(0xffDBEAFE); // xanh dương nhạt
          } else {
            bgColor = Colors.grey.shade200; // mặc định
          }

          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() {
                _selectedPaymentMethodIndex = index;
              }),
              child: Container(
                margin: EdgeInsets.only(right: index == 0 ? 12 : 0),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xffF0FDF4) : Colors.white,
                  border: Border.all(
                    color: isSelected ? Colors.green : Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Icon(
                        _paymentMethods[index]['icon'],
                        color: isSelected ? Colors.green : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _paymentMethods[index]['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.green : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Color(0xffEFF6FF),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Phí đỗ xe:', style: TextStyle(fontSize: 14)),
                Text(
                  _calculateFeeDisplay(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2563EB),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                final PriceShift selectedShift =
                    _vehicleTypes[_selectedVehicleTypeIndex!];
                final int carTypeId = selectedShift.refCarType;
                String paymentMethod = _selectedPaymentMethodIndex == 0
                    ? "CARD"
                    : "CASH";
                final token = await TokenStorage.getToken();
                final service = TransactionService();
                await service.checkIn(
                  lotId: _selectedLot!.id,
                  parkingCode: _selectedLot!.parkingCode,
                  amount: _calculateFeeAmount(),
                  paymentType: paymentMethod,
                  refCarTypeId: carTypeId,
                  blockNum: _selectedHourIndex,
                  plateNumber: _plateNumberController.text,
                  shiftType: _selectedLot!.refParkingType,
                  imageFile: widget.capturedImage,
                  token: token,
                );
              },
              icon: Image.asset('assets/images/save_icon.png'),
              label: const Text(
                'Lưu thông tin xe vào',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF60A5FA),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
