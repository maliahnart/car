// import 'package:car/config/transaction_state/transaction_list_bloc.dart';
// import 'package:car/config/transaction_state/transaction_list_event.dart';
// import 'package:car/config/transaction_state/transaction_list_state.dart';
// import 'package:car/models/car_sample.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// class ListCarScreen extends StatefulWidget {
//   const ListCarScreen({super.key});

//   @override
//   State<ListCarScreen> createState() => _ListCarScreenState();
// }

// class _ListCarScreenState extends State<ListCarScreen> {
//   final _searchController = TextEditingController();
//   int _selectedStatusIndex = 0;
//   int _selectedPaymentIndex = 0;
//   int _selectedTimeIndex = 0;
//   bool _isFilterExpanded = true;
//   final _scrollController = ScrollController();
//   // final List<CarSample> _carInfo = [
//   //   CarSample(
//   //     imgUrl: 'assets/images/car_image.png',
//   //     licensePlate: '29B-98765',
//   //     paymentStatus: PaymentStatus.paid,
//   //     timeStatus: TimeStatus.onTime,
//   //     exitTime: '09:15:00',
//   //     exitDate: '3/9/2025',
//   //     fee: '50000.đ',
//   //   ),
//   //   CarSample(
//   //     imgUrl: 'assets/images/car_image.png',
//   //     licensePlate: '29B-98765',
//   //     paymentStatus: PaymentStatus.paid,
//   //     timeStatus: TimeStatus.onTime,
//   //     exitTime: '09:15:00',
//   //     exitDate: '3/9/2025',
//   //     fee: '50000.đ',
//   //   ),
//   //   CarSample(
//   //     imgUrl: 'assets/images/car_image.png',
//   //     licensePlate: '29B-98765',
//   //     paymentStatus: PaymentStatus.paid,
//   //     timeStatus: TimeStatus.onTime,
//   //     exitTime: '09:15:00',
//   //     exitDate: '3/9/2025',
//   //     fee: '50000.đ',
//   //   ),
//   // ];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _scrollController.addListener(_onScroll);

//   }
//    @override
//   void dispose() {
//     _searchController.dispose();
//     _scrollController.removeListener(_onScroll);
//     _scrollController.dispose();
//     super.dispose();
//   }
//     void _onScroll() {
//     if (_isBottom) {
//       context.read<TransactionListBloc>().add(TransactionsFetched());
//     }
//   }
//     bool get _isBottom {
//     if (!_scrollController.hasClients) return false;
//     final maxScroll = _scrollController.position.maxScrollExtent;
//     final currentScroll = _scrollController.offset;
//     return currentScroll >= (maxScroll * 0.9);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             onPressed: () {
//               context.go('/home');
//             },
//             icon: Icon(Icons.arrow_back, color: Colors.white),
//           ),
//           centerTitle: true,
//           toolbarHeight: 70,
//           title: Text(
//             'Danh sách xe',
//             style: TextStyle(fontSize: 15, color: Colors.white),
//           ),
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(-14326805), Color(-14856488)],
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//               ),
//             ),
//           ),
//         ),
//         body: BlocBuilder<TransactionListBloc, TransactionListState>(
//           builder: (context,state){

//           },
//         )(
//           child: Container(
//             decoration: const BoxDecoration(
//               color: Color(-789258),
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(24),
//                 topRight: Radius.circular(24),
//               ),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(24),
//                 topRight: Radius.circular(24),
//               ),
//               child: ListView.builder(
//                 itemCount: _carInfo.length + 1,
//                 itemBuilder: (context, index) {
//                   if (index == 0) {
//                     return _buildFilterSection();
//                   }
//                   final carInfo = _carInfo[index - 1];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 8,
//                     ),
//                     child: _buildCarCard(carInfo),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFilterSection() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       color: Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildSearchBar(),
//           const SizedBox(height: 8),
//           _buildClassifyCar(),
//           const SizedBox(height: 16),
//           GestureDetector(
//             onTap: () =>
//                 setState(() {
//                   _isFilterExpanded = !_isFilterExpanded;
//                 }),
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Image.asset('assets/images/Filter.png'),
//                   SizedBox(width: 8),
//                   const Text('Bộ lọc'),
//                   Icon(
//                     _isFilterExpanded ? Icons.expand_less : Icons.expand_more,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 12),
//           if (_isFilterExpanded) _buildAdvancedFilters(),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return TextField(
//       controller: _searchController,
//       decoration: InputDecoration(
//         hintText: 'Tìm kiếm theo biển số...',
//         hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
//         suffixIcon: Padding(
//           padding: EdgeInsets.all(2),
//           child: Image.asset(
//             "assets/images/search_icon.png",
//             width: 20,
//             height: 20,
//           ),
//         ),
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//       ),
//     );
//   }

//   Widget _buildClassifyCar() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Color(-789258),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _buildFilterChipTest(
//               label: 'Tất cả',
//               isSelected: _selectedStatusIndex == 0,
//               onTap: () =>
//                   setState(() {
//                     _selectedStatusIndex = 0;
//                   }),
//             ),
//             _buildFilterChipTest(
//               label: 'Xe trong bãi',
//               isSelected: _selectedStatusIndex == 1,
//               onTap: () =>
//                   setState(() {
//                     _selectedStatusIndex = 1;
//                   }),
//             ),
//             _buildFilterChipTest(
//               label: 'Đã ra',
//               isSelected: _selectedStatusIndex == 2,
//               onTap: () =>
//                   setState(() {
//                     _selectedStatusIndex = 2;
//                   }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAdvancedFilters() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Color(-1),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           color: Colors.grey,
//           width: 0.2,
//         ),
//       ),
//       padding: const EdgeInsets.only(top: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Bộ lọc nâng cao',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//             ),
//             const SizedBox(height: 12),
//             const Text('Thanh toán', style: TextStyle(fontSize: 12)),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildFilterChip(
//                   label: 'Tất cả',
//                   isSelected: _selectedPaymentIndex == 0,
//                   onTap: () => setState(() => _selectedPaymentIndex = 0),
//                   isPrimary: true,
//                 ),
//                 _buildFilterChip(
//                   label: 'Đã thanh toán',
//                   isSelected: _selectedPaymentIndex == 1,
//                   onTap: () => setState(() => _selectedPaymentIndex = 1),
//                   isPrimary: true,
//                 ),
//                 _buildFilterChip(
//                   label: 'Chưa thanh toán',
//                   isSelected: _selectedPaymentIndex == 2,
//                   onTap: () => setState(() => _selectedPaymentIndex = 2),
//                   isPrimary: true,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             const Text('Thời gian gửi xe', style: TextStyle(fontSize: 12)),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildFilterChip(
//                   label: 'Tất cả',
//                   isSelected: _selectedTimeIndex == 0,
//                   onTap: () => setState(() => _selectedTimeIndex = 0),
//                   isPrimary: true,
//                 ),
//                 _buildFilterChip(
//                   label: 'Quá hạn',
//                   isSelected: _selectedTimeIndex == 1,
//                   onTap: () => setState(() => _selectedTimeIndex = 1),
//                   isPrimary: true,
//                 ),
//                 _buildFilterChip(
//                   label: 'Chưa quá hạn',
//                   isSelected: _selectedTimeIndex == 2,
//                   onTap: () => setState(() => _selectedTimeIndex = 2),
//                   isPrimary: true,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFilterChip({
//     required String label,
//     required bool isSelected,
//     required VoidCallback onTap,
//     bool isPrimary = false,
//   }) {
//     double totalPadding = 24;
//     double chipWidth =
//         (MediaQuery
//             .of(context)
//             .size
//             .width - totalPadding * 2.5) / 3;

//     return SizedBox(
//       width: chipWidth,
//       child: ChoiceChip(
//         label: Center(child: Text(label, textAlign: TextAlign.center)),
//         selected: isSelected,
//         onSelected: (_) => onTap(),
//         backgroundColor: Colors.grey[200],
//         labelPadding: EdgeInsets.symmetric(horizontal: 4),
//         selectedColor: isPrimary ? Color(-12877066) : Color(-789258),
//         labelStyle: TextStyle(
//           color: isSelected && isPrimary ? Colors.white : Color(-11840157),
//           fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//           fontSize: 11,
//         ),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         showCheckmark: false,
//       ),
//     );
//   }

//   Widget _buildFilterChipTest({
//     required String label,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: onTap,
//         child: AnimatedContainer(
//           duration: Duration(milliseconds: 250),
//           padding: EdgeInsets.symmetric(vertical: 12),
//           margin: EdgeInsets.symmetric(horizontal: 2),
//           decoration: BoxDecoration(
//             color: isSelected ? Colors.white : Colors.transparent,
//             borderRadius: BorderRadius.circular(8),
//             boxShadow: isSelected
//                 ? [
//               BoxShadow(
//                 color: Colors.black.withAlpha((0.1 * 255).toInt()),
//                 blurRadius: 4,
//                 offset: Offset(0, 2),
//               ),
//             ]
//                 : null,
//           ),
//           child: Text(
//             label,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: isSelected ? Color(-14326805) : Color(-11840157),
//               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               fontSize: 14,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCarCard(CarSample carlmao) {
//     final bool isPaid = carlmao.paymentStatus == PaymentStatus.paid;
//     final bool isOverdue = carlmao.timeStatus == TimeStatus.overdue;

//     return Card(
//       elevation: 4,
//       color: Color(-789258),
//       shadowColor: Colors.grey.withAlpha((0.2*255).toInt()),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: 80,
//               height: 60,
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(8),
//                 image: DecorationImage(
//                   image: AssetImage(carlmao.imgUrl),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         carlmao.licensePlate,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w900,
//                           fontSize: 18,
//                           color: Color(-15656921)
//                         ),
//                       ),
//                       _buildStatusChip(
//                         text: isPaid ? 'Đã thanh toán' : 'Chưa thanh toán',
//                         color: isPaid ? Color(-15293622) : Color(-1419252),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),

//                   Row(
//                     children: [
//                       // Bên trái
//                       Text(
//                         'Điện tử',
//                         style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                       ),

//                       // Cho phần giữa căn đúng
//                       Expanded(
//                         child: Center(
//                           child: Text(
//                             '•',
//                             style: TextStyle(color: Colors.grey[600]),
//                           ),
//                         ),
//                       ),

//                       Text(
//                         isOverdue ? 'Quá thời gian' : 'Còn thời gian',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Thời gian ra\ndự kiến:',
//                           style: TextStyle(color: Colors.grey[600],
//                           fontSize: 14),),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(carlmao.exitTime, style: const TextStyle(
//                               fontWeight: FontWeight.bold)),
//                           Text(carlmao.exitDate, style: const TextStyle(
//                               fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Phí đỗ xe:',
//                           style: TextStyle(color: Colors.grey[600],
//                           fontSize: 14)),
//                       Text(
//                         carlmao.fee,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                           color: Color(-14326805),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),

//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             padding: EdgeInsets.zero,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10)),
//                             elevation: 0,
//                             backgroundColor: Colors.transparent,
//                           ),
//                           child: Ink(
//                             decoration: BoxDecoration(
//                               gradient: const LinearGradient(
//                                 colors: [Color(0xFF3B82F6), Color(0xFF9333EA)],
//                                 begin: Alignment.centerLeft,
//                                 end: Alignment.centerRight,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(vertical: 12),
//                               alignment: Alignment.center,
//                               child: const Text(
//                                 'Xem giao dịch',
//                                 style: TextStyle(fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Color(-789258),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: IconButton(
//                           onPressed: () {},
//                           icon: const Icon(Icons.print_outlined),
//                           color: Colors.grey[700],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _buildStatusChip({required String text, required Color color}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: color.withAlpha((0.09 * 255).toInt()),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: color),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: color,
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }

import 'package:car/config/transaction_state/transaction_list_bloc.dart';
import 'package:car/config/transaction_state/transaction_list_event.dart';
import 'package:car/config/transaction_state/transaction_list_state.dart';
import 'package:car/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ListCarScreen extends StatefulWidget {
  const ListCarScreen({super.key});

  @override
  State<ListCarScreen> createState() => _ListCarScreenState();
}

class _ListCarScreenState extends State<ListCarScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  bool _isFilterExpanded = true;
  int _selectedPaymentIndex = 0;
  int _selectedTimeIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<TransactionListBloc>().add(TransactionsFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.go('/home'),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          centerTitle: true,
          toolbarHeight: 70,
          title: const Text(
            'Danh sách xe',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(-14326805), Color(-14856488)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
        body: BlocBuilder<TransactionListBloc, TransactionListState>(
          builder: (context, state) {
            // Xử lý các trạng thái khác nhau
            switch (state.status) {
              case TransactionListStatus.failure:
                return Center(
                  child: Text('Lỗi tải dữ liệu: ${state.errorMessage}'),
                );

              case TransactionListStatus.initial:
              case TransactionListStatus.loading:
                if (state.transactions.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return _buildTransactionList(state);

              case TransactionListStatus.success:
                // DÙ DANH SÁCH RỖNG HAY KHÔNG, CHÚNG TA VẪN DÙNG MỘT CẤU TRÚC DUY NHẤT
                // CÓ THỂ CUỘN ĐƯỢC.
                return Container(
                  // Giữ lại Container và ClipRRect bên ngoài
                  decoration: const BoxDecoration(
                    color: Color(-789258),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    child: ListView(
                      // << SỬ DỤNG ListView THAY VÌ Column >>
                      children: [
                        // Item đầu tiên luôn là bộ lọc
                        _buildFilterSection(state),

                        // Nếu danh sách rỗng, hiển thị thông báo
                        if (state.transactions.isEmpty)
                          Padding(
                            // Lấy chiều cao còn lại của màn hình để căn giữa thông báo
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.2,
                            ),
                            child: const Center(
                              child: Text('Không có giao dịch nào.'),
                            ),
                          )
                        // Nếu không rỗng, hiển thị danh sách
                        else
                          ...state.transactions.map((transaction) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: _buildCarCard(transaction),
                            );
                          }).toList(),

                        // Hiển thị loading ở cuối nếu cần tải thêm
                        if (state.status == TransactionListStatus.loading &&
                            state.transactions.isNotEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                      ],
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }

  Widget _buildTransactionList(TransactionListState state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<TransactionListBloc>().add(
          TransactionsRefreshed(
            parkingStatus: state.parkingStatus,
            plateNumber: state.plateNumber,
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Color(-789258),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: state.hasReachedMax
                ? state.transactions.length + 1
                : state.transactions.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildFilterSection(state);
              }
              if (index > state.transactions.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final transaction = state.transactions[index - 1];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: _buildCarCard(transaction),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection(TransactionListState state) {
    return Container(
      padding: const EdgeInsets.all(14),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(state),
          const SizedBox(height: 8),
          _buildClassifyCar(state),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => setState(() => _isFilterExpanded = !_isFilterExpanded),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/Filter.png'),
                  const SizedBox(width: 8),
                  const Text('Bộ lọc'),
                  Icon(
                    _isFilterExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (_isFilterExpanded) _buildAdvancedFilters(),
        ],
      ),
    );
  }

  Widget _buildSearchBar(TransactionListState state) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Tìm kiếm theo biển số...',
        hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(2),
          child: Image.asset(
            "assets/images/search_icon.png",
            width: 20,
            height: 20,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      onSubmitted: (value) {
        context.read<TransactionListBloc>().add(
          TransactionsRefreshed(
            parkingStatus: state.parkingStatus,
            plateNumber: value.trim(),
          ),
        );
      },
    );
  }

  Widget _buildClassifyCar(TransactionListState state) {
    print("--- UI BUILD LẠI VỚI parkingStatus: ${state.parkingStatus} ---");
    return Container(
      decoration: BoxDecoration(
        color: const Color(-789258),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildFilterChipTest(
              label: 'Tất cả',
              isSelected: state.parkingStatus == null, // Dựa vào state của BLoC
              onTap: () {
                print(">>> NHẤN NÚT 'Tất cả' -> Gửi event parkingStatus: null");

                context.read<TransactionListBloc>().add(
                  const TransactionsRefreshed(parkingStatus: null),
                );
              },
            ),
            _buildFilterChipTest(
              label: 'Xe trong bãi',
              isSelected: state.parkingStatus == 1, 
              onTap: () {
                print(
                  ">>> NHẤN NÚT 'Xe trong bãi' -> Gửi event parkingStatus: 1",
                );

                context.read<TransactionListBloc>().add(
                  const TransactionsRefreshed(parkingStatus: 1),
                );
              },
            ),
            _buildFilterChipTest(
              label: 'Đã ra',
              isSelected: state.parkingStatus == 0, 
              onTap: () {
                // Gửi event để lọc lại danh sách
                context.read<TransactionListBloc>().add(
                  const TransactionsRefreshed(parkingStatus: 0),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancedFilters() {
    return Container(
      decoration: BoxDecoration(
        color: Color(-1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      padding: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bộ lọc nâng cao',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 12),
            const Text('Thanh toán', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFilterChip(
                  label: 'Tất cả',
                  isSelected: _selectedPaymentIndex == 0,
                  onTap: () => setState(() => _selectedPaymentIndex = 0),
                  isPrimary: true,
                ),
                _buildFilterChip(
                  label: 'Đã thanh toán',
                  isSelected: _selectedPaymentIndex == 1,
                  onTap: () => setState(() => _selectedPaymentIndex = 1),
                  isPrimary: true,
                ),
                _buildFilterChip(
                  label: 'Chưa thanh toán',
                  isSelected: _selectedPaymentIndex == 2,
                  onTap: () => setState(() => _selectedPaymentIndex = 2),
                  isPrimary: true,
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Thời gian gửi xe', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFilterChip(
                  label: 'Tất cả',
                  isSelected: _selectedTimeIndex == 0,
                  onTap: () => setState(() => _selectedTimeIndex = 0),
                  isPrimary: true,
                ),
                _buildFilterChip(
                  label: 'Quá hạn',
                  isSelected: _selectedTimeIndex == 1,
                  onTap: () => setState(() => _selectedTimeIndex = 1),
                  isPrimary: true,
                ),
                _buildFilterChip(
                  label: 'Chưa quá hạn',
                  isSelected: _selectedTimeIndex == 2,
                  onTap: () => setState(() => _selectedTimeIndex = 2),
                  isPrimary: true,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    double totalPadding = 22;
    double chipWidth =
        (MediaQuery.of(context).size.width - totalPadding * 2.66) / 3;

    return SizedBox(
      width: chipWidth,
      child: ChoiceChip(
        padding: const EdgeInsets.all(0),
        label: Center(child: Text(label, textAlign: TextAlign.center)),
        selected: isSelected,
        onSelected: (_) => onTap(),
        backgroundColor: Colors.grey[200],
        labelPadding: EdgeInsets.symmetric(horizontal: 4),
        selectedColor: isPrimary ? Color(-12877066) : Color(-789258),
        labelStyle: TextStyle(
          color: isSelected && isPrimary ? Colors.white : Color(-11840157),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 12,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        showCheckmark: false,
      ),
    );
  }

  Widget _buildFilterChipTest({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(vertical: 12),
          margin: EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.1 * 255).toInt()),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Color(-14326805) : Color(-11840157),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCarCard(Transaction transaction) {
    final isPaid = true;
    final isOverdue = transaction.expiredParking == "EXPIRED";
    final formattedFee = NumberFormat.decimalPattern(
      'vi_VN',
    ).format(transaction.amount);
    final formattedTime = DateFormat(
      'HH:mm:ss',
    ).format(transaction.estimateCheckOutTime.toLocal());
    final formattedDate = DateFormat(
      'dd/MM/yyyy',
    ).format(transaction.estimateCheckOutTime.toLocal());

    return Card(
      elevation: 4,
      color: const Color(-789258),
      shadowColor: Colors.grey.withAlpha((0.2 * 255).toInt()),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                image: transaction.pathImg.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(transaction.pathImg),
                        fit: BoxFit.cover,
                      )
                    : const DecorationImage(
                        image: AssetImage('assets/images/car_image.png'),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        transaction.plateNumber, // << Dữ liệu từ BLoC
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: Color(-15656921),
                        ),
                      ),
                      _buildStatusChip(
                        text: isPaid ? 'Đã thanh toán' : 'Chưa thanh toán',
                        color: isPaid
                            ? const Color(-15293622)
                            : const Color(-1419252),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        transaction.paymentType == "CARD"
                            ? 'Điện tử'
                            : 'Tiền mặt', // << Dữ liệu từ BLoC
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            '•',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ),
                      Text(
                        isOverdue
                            ? 'Quá thời gian'
                            : 'Còn thời gian', // << Dữ liệu từ BLoC
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Thời gian ra\ndự kiến:',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            formattedTime, // << Dữ liệu đã format
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            formattedDate, // << Dữ liệu đã format
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phí đỗ xe:',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      Text(
                        '$formattedFee đ', // << Dữ liệu đã format
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(-14326805),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF3B82F6), Color(0xFF9333EA)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              alignment: Alignment.center,
                              child: const Text(
                                'Xem giao dịch',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(-789258),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.print_outlined),
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip({required String text, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha((0.09 * 255).toInt()),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
