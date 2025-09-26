import 'dart:async';

import 'package:car/config/state/parking_lot_bloc.dart';
import 'package:car/config/state/parking_lot_event.dart';
import 'package:car/config/token_storage.dart';
import 'package:car/models/parking_lot.dart';
import 'package:car/services/parking_lot_service.dart';
import 'package:car/widgets/parking_lot_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChooseParking extends StatefulWidget {
  const ChooseParking({super.key});

  @override
  State<ChooseParking> createState() => _ChooseParkingState();
}

class _ChooseParkingState extends State<ChooseParking> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  String? _error;
  List<ParkingLot> _parkingLots = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _fetchParkingLots("xe");
    _searchController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        _fetchParkingLots(_searchController.text);
      });
    });
  }

  Future<void> _fetchParkingLots(String keyword) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final token = await TokenStorage.getToken();
      final service = ParkingLotService();
      final lots = await service.getParkingLots(keyword, token!);

      if (mounted) {
        setState(() {
          _parkingLots = lots;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = "Không thể tải dữ liệu";
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf4f3ff),
      appBar: _buildNormalAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildSearchBar(),
            Expanded(child: _buildNormalBody()),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildNormalAppBar() {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9333EA), Color(0xFF3B82F6)],
            begin: Alignment(0, 0.95),
            end: Alignment(-0.23, -0.86),
          ),
        ),
      ),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chọn bãi đỗ xe',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'Thu phí viên • Chọn nơi làm việc',
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ],
      ),
      toolbarHeight: 80,
      titleSpacing: 16,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () async {
            await TokenStorage.clearToken();
            context.go('/login');
          },
          icon: Image.asset('assets/images/Logout Rounded Left.png'),
        ),
      ],
    );
  }

  Widget _buildNormalBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(child: Text(_error!));
    }
    if (_parkingLots.isEmpty) {
      return const Center(child: Text('Không tìm thấy bãi đỗ.'));
    }

    return ListView.builder(
      itemCount: _parkingLots.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) return _buildListHeader(_parkingLots.length);
        final lot = _parkingLots[index - 1];
        return ParkingLotCard(
          lot: lot,
          onTap: () {
            // context.push('/create_transaction', extra: lot);
            context.read<ParkingLotBloc>().add(ParkingLotSelected(lot));
            context.push('/home');
          },
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Tìm kiếm bãi đỗ',
            hintStyle: TextStyle(color: Colors.grey[500]),
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildListHeader(int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.list_alt, color: Color.fromARGB(255, 58, 108, 179)),
          const SizedBox(width: 8),
          Text(
            'Danh sách bãi đỗ xe ($count)',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
