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
// import 'package:car/config/transaction_state/transaction_list_bloc.dart';
// import 'package:car/config/transaction_state/transaction_list_event.dart';
// import 'package:car/config/transaction_state/transaction_list_state.dart';
// import 'package:car/models/transaction.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:intl/intl.dart';

// class ListCarScreen extends StatefulWidget {
//   const ListCarScreen({super.key});

//   @override
//   State<ListCarScreen> createState() => _ListCarScreenState();
// }

// class _ListCarScreenState extends State<ListCarScreen> {
//   final _searchController = TextEditingController();
//   bool _isFilterExpanded = true;
//     bool _isFetching = false;

//   // 1. initState chỉ gọi event MỘT LẦN khi BLoC được tạo
//   @override
//   void initState() {
//     super.initState();
//     if (context.read<TransactionListBloc>().state.status == TransactionListStatus.initial) {
//       context.read<TransactionListBloc>().add(TransactionsFetched());
//     }
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   // 2. Build method SẠCH, không có logic gọi event
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             onPressed: () => context.go('/home'),
//             icon: const Icon(Icons.arrow_back, color: Colors.white),
//           ),
//           centerTitle: true,
//           toolbarHeight: 70,
//           title: const Text(
//             'Danh sách xe',
//             style: TextStyle(fontSize: 15, color: Colors.white),
//           ),
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(-14326805), Color(-14856488)],
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//               ),
//             ),
//           ),
//         ),
//         body: BlocListener<TransactionListBloc, TransactionListState>(
//         listener: (context, state) {
//           // Khi BLoC emit một state mới (thành công hoặc thất bại),
//           // điều đó có nghĩa là quá trình fetch đã kết thúc.
//           // Chúng ta có thể "bật lại cầu chì" để cho phép các yêu cầu fetch mới.
//           if (state.status == TransactionListStatus.success || state.status == TransactionListStatus.failure) {
//             setState(() {
//               _isFetching = false;
//             });
//           }
//         },
//           child: BlocBuilder<TransactionListBloc, TransactionListState>(
//             builder: (context, state) {
//               print("--- BlocBuilder is building with Status: ${state.status}, Transaction Count from STATE: ${state.transactions.length} ---");
//               switch (state.status) {
//                 case TransactionListStatus.failure:
//                   return Center(
//                     child: Text('Lỗi tải dữ liệu: ${state.errorMessage}'),
//                   );
//                 case TransactionListStatus.initial:
//                   return const Center(child: CircularProgressIndicator());
//                 case TransactionListStatus.loading:
//                 case TransactionListStatus.success:
//                   if (state.transactions.isEmpty && state.status == TransactionListStatus.loading) {
//                      return const Center(child: CircularProgressIndicator());
//                   }
//                   return _buildTransactionList(state);
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   // 3. NotificationListener xử lý cuộn một cách an toàn
//   Widget _buildTransactionList(TransactionListState state) {
//     return RefreshIndicator(
//       onRefresh: () async {
//         context.read<TransactionListBloc>().add(
//               TransactionsRefreshed(
//                 parkingStatus: state.parkingStatus,
//                 plateNumber: state.plateNumber,
//                 transactionStatus: state.transactionStatus,
//                 expiredParking: state.expiredParking,
//               ),
//             );
//       },
//       child: Container(
//         decoration: const BoxDecoration(
//           color: Color(-789258),
//           borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
//         ),
//         child: ClipRRect(
//           borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
//           child: NotificationListener<ScrollNotification>(
//             onNotification: (notification) {
//               final metrics = notification.metrics;
//               if (metrics.pixels >= metrics.maxScrollExtent * 0.9) {
//                 final currentState = context.read<TransactionListBloc>().state;

//               if (!currentState.hasReachedMax && !_isFetching) {

//                 // BƯỚC 1: "NGẮT CẦU CHÌ" -> Ngăn các event tiếp theo
//                 setState(() {
//                   _isFetching = true;
//                 });

//                 // BƯỚC 2: Gửi event đi
//                 context.read<TransactionListBloc>().add(TransactionsFetched());
//               }
//             }
//             return false;
//           },
//             child: ListView.builder(
//               itemCount: state.transactions.length + 2,
//               itemBuilder: (context, index) {
//                 if (index == 0) return _buildFilterSection(state);
//                 if (index <= state.transactions.length) {
//                   final transaction = state.transactions[index - 1];
//                   print("--- UI is building car card for INDEX: ${index - 1}, Plate: ${transaction.plateNumber} ---");
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     child: _buildCarCard(transaction),
//                   );
//                 }
//                 if (state.hasReachedMax && state.transactions.isEmpty) {
//                   return Padding(
//                     padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
//                     child: const Center(child: Text('Không có giao dịch nào.')),
//                   );
//                 }
//                 if (!state.hasReachedMax) {
//                   return const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 16.0),
//                     child: Center(child: CircularProgressIndicator()),
//                   );
//                 }
//                 return const SizedBox.shrink();
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFilterSection(TransactionListState state) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       color: Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildSearchBar(state),
//           const SizedBox(height: 8),
//           _buildClassifyCar(state),
//           const SizedBox(height: 16),
//           GestureDetector(
//             onTap: () => setState(() => _isFilterExpanded = !_isFilterExpanded),
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
//                   const SizedBox(width: 8),
//                   const Text('Bộ lọc'),
//                   Icon(
//                     _isFilterExpanded ? Icons.expand_less : Icons.expand_more,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 12),
//           if (_isFilterExpanded) _buildAdvancedFilters(state),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchBar(TransactionListState state) {
//     return TextField(
//       controller: _searchController,
//       decoration: InputDecoration(
//         hintText: 'Tìm kiếm theo biển số...',
//         hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
//         suffixIcon: Padding(
//           padding: const EdgeInsets.all(2),
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
//       onSubmitted: (value) {
//         context.read<TransactionListBloc>().add(
//               TransactionsRefreshed(
//                 parkingStatus: state.parkingStatus,
//                 plateNumber: value.trim(),
//               ),
//             );
//       },
//     );
//   }

//  Widget _buildClassifyCar(TransactionListState state) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(-789258),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _buildFilterChipTest(
//               label: 'Tất cả ${state.parkingStatus == null ? '(${state.totalCount})' : ''}',
//               isSelected: state.parkingStatus == null,
//               onTap: () {
//                   // ================== LOGGING HERE ==================
//                 print("\n👆 Bấm nút 'Tất cả'.");
//                 print("   - Trạng thái BLoC *TRƯỚC KHI* gửi event:");
//                 print("     -> state.parkingStatus hiện tại là: ${state.parkingStatus}");

//                 // Gửi event đi mà không cần điều kiện if
//                 context.read<TransactionListBloc>().add(
//                       const TransactionsRefreshed(parkingStatus: null),
//                     );
//                 print("   ✅ Đã gửi event: TransactionsRefreshed(parkingStatus: null)");
//                 print("-------------------------------------------------");
//                 // ==================================================
//               },
//             ),
//             _buildFilterChipTest(
//               label: 'Xe trong bãi ${state.parkingStatus == 1 ? '(${state.totalCount})' : ''}',
//               isSelected: state.parkingStatus == 1,
//               onTap: () {
//                 // ================== LOGGING HERE ==================
//                 print("\n👆 Bấm nút 'Xe trong bãi'.");
//                 print("   - State hiện tại (trước khi check): state.parkingStatus = ${state.parkingStatus}");

//                 if (state.parkingStatus != 1) {
//                   print("   ✅ Điều kiện (state.parkingStatus != 1) là TRUE. Gửi event...");
//                   context.read<TransactionListBloc>().add(
//                         const TransactionsRefreshed(parkingStatus: 1),
//                       );
//                 } else {
//                   print("   ❌ Điều kiện (state.parkingStatus != 1) là FALSE. KHÔNG gửi event.");
//                 }
//                 print("-------------------------------------------------");
//                 // ==================================================
//               },
//             ),
//             _buildFilterChipTest(
//               label: 'Đã ra ${state.parkingStatus == 2 ? '(${state.totalCount})' : ''}',
//               isSelected: state.parkingStatus == 2,
//               onTap: () {
//                 // ================== LOGGING HERE ==================
//                 print("\n👆 Bấm nút 'Đã ra'.");
//                 print("   - State hiện tại (trước khi check): state.parkingStatus = ${state.parkingStatus}");

//                 if (state.parkingStatus != 2) {
//                    print("   ✅ Điều kiện (state.parkingStatus != 2) là TRUE. Gửi event...");
//                   context.read<TransactionListBloc>().add(
//                         const TransactionsRefreshed(parkingStatus: 2),
//                       );
//                 } else {
//                   print("   ❌ Điều kiện (state.parkingStatus != 2) là FALSE. KHÔNG gửi event.");
//                 }
//                 print("-------------------------------------------------");
//                 // ==================================================
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAdvancedFilters(TransactionListState state) {
//     void _refreshWithNewFilters({
//       int? payment,
//       String? expired,
//     }) {
//       context.read<TransactionListBloc>().add(
//             TransactionsRefreshed(
//               parkingStatus: state.parkingStatus,
//               plateNumber: state.plateNumber,
//               transactionStatus: payment,
//               expiredParking: expired,
//             ),
//           );
//     }

//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(-1),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.grey),
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
//                   isSelected: state.transactionStatus == null,
//                   onTap: () => _refreshWithNewFilters(payment: null, expired: state.expiredParking),
//                   isPrimary: true,
//                 ),
//                 _buildFilterChip(
//                   label: 'Đã thanh toán',
//                   isSelected: state.transactionStatus == 1,
//                   onTap: () => _refreshWithNewFilters(payment: 1, expired: state.expiredParking),
//                   isPrimary: true,
//                 ),
//                 _buildFilterChip(
//                   label: 'Chưa thanh toán',
//                   isSelected: state.transactionStatus == 0,
//                   onTap: () => _refreshWithNewFilters(payment: 0, expired: state.expiredParking),
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
//                   isSelected: state.expiredParking == null,
//                   onTap: () => _refreshWithNewFilters(payment: state.transactionStatus, expired: null),
//                   isPrimary: true,
//                 ),
//                 _buildFilterChip(
//                   label: 'Quá hạn',
//                   isSelected: state.expiredParking == 'EXPIRED',
//                   onTap: () => _refreshWithNewFilters(payment: state.transactionStatus, expired: 'EXPIRED'),
//                   isPrimary: true,
//                 ),
//                 _buildFilterChip(
//                   label: 'Chưa quá hạn',
//                   isSelected: state.expiredParking == 'NOT_EXPIRED',
//                   onTap: () => _refreshWithNewFilters(payment: state.transactionStatus, expired: 'NOT_EXPIRED'),
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
//     double totalPadding = 22;
//     double chipWidth = (MediaQuery.of(context).size.width - totalPadding * 2.66) / 3;

//     return SizedBox(
//       width: chipWidth,
//       child: ChoiceChip(
//         padding: const EdgeInsets.all(0),
//         label: Center(child: Text(label, textAlign: TextAlign.center)),
//         selected: isSelected,
//         onSelected: (_) => onTap(),
//         backgroundColor: Colors.grey[200],
//         labelPadding: const EdgeInsets.symmetric(horizontal: 4),
//         selectedColor: isPrimary ? const Color(-12877066) : const Color(-789258),
//         labelStyle: TextStyle(
//           color: isSelected && isPrimary ? Colors.white : const Color(-11840157),
//           fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//           fontSize: 12,
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
//           duration: const Duration(milliseconds: 250),
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           margin: const EdgeInsets.symmetric(horizontal: 2),
//           decoration: BoxDecoration(
//             color: isSelected ? Colors.white : Colors.transparent,
//             borderRadius: BorderRadius.circular(8),
//             boxShadow: isSelected
//                 ? [
//                     BoxShadow(
//                       color: Colors.black.withAlpha((0.1 * 255).toInt()),
//                       blurRadius: 4,
//                       offset: const Offset(0, 2),
//                     ),
//                   ]
//                 : null,
//           ),
//           child: Text(
//             label,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: isSelected ? const Color(-14326805) : const Color(-11840157),
//               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               fontSize: 14,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCarCard(Transaction transaction) {
//     final isPaid = transaction.transactionStatus;
//     final isOverdue = transaction.expiredParking;
//     final formattedFee = NumberFormat.decimalPattern(
//       'vi_VN',
//     ).format(transaction.amount);
//     final formattedTime = DateFormat(
//       'HH:mm:ss',
//     ).format(transaction.estimateCheckOutTime.toLocal());
//     final formattedDate = DateFormat(
//       'dd/MM/yyyy',
//     ).format(transaction.estimateCheckOutTime.toLocal());

//     return Card(
//       elevation: 4,
//       color: const Color(-789258),
//       shadowColor: Colors.grey.withAlpha((0.2 * 255).toInt()),
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
//                 image: transaction.pathImg.isNotEmpty
//                     ? DecorationImage(
//                         image: NetworkImage(transaction.pathImg),
//                         fit: BoxFit.cover,
//                       )
//                     : const DecorationImage(
//                         image: AssetImage('assets/images/car_image.png'),
//                         fit: BoxFit.cover,
//                       ),
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
//                         transaction.plateNumber,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w900,
//                           fontSize: 18,
//                           color: Color(-15656921),
//                         ),
//                       ),
//                       _buildStatusChip(
//                         text: isPaid == 1 ? 'Đã thanh toán' : 'Chưa thanh toán',
//                         color: isPaid == 1 ? const Color(-15293622) : const Color(-1419252),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Text(
//                         transaction.paymentType == "CARD" ? 'Điện tử' : 'Tiền mặt',
//                         style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                       ),
//                       Expanded(
//                         child: Center(
//                           child: Text(
//                             '•',
//                             style: TextStyle(color: Colors.grey[600]),
//                           ),
//                         ),
//                       ),
//                       Text(
//                         isOverdue == "EXPIRED" ? 'Quá thời gian' : 'Còn thời gian',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Thời gian ra\ndự kiến:',
//                         style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             formattedTime,
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             formattedDate,
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Phí đỗ xe:',
//                         style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                       ),
//                       Text(
//                         '$formattedFee đ',
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
//                               borderRadius: BorderRadius.circular(10),
//                             ),
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
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Container(
//                         decoration: BoxDecoration(
//                           color: const Color(-789258),
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
//       padding: const EdgeInsets.all(4),
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
  bool _isFilterExpanded = true;
  bool _isFetching = false;

  // 1. initState chỉ gọi event MỘT LẦN khi BLoC được tạo
  @override
  void initState() {
    super.initState();
    if (context.read<TransactionListBloc>().state.status ==
        TransactionListStatus.initial) {
      context.read<TransactionListBloc>().add(TransactionsFetched());
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // 2. Build method SẠCH, không có logic gọi event
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
        body: BlocListener<TransactionListBloc, TransactionListState>(
          listener: (context, state) {
            if (state.status == TransactionListStatus.success ||
                state.status == TransactionListStatus.failure) {
              setState(() {
                _isFetching = false;
              });
            }
          },
          child: RefreshIndicator(
            // <--- DI CHUYỂN RefreshIndicator RA ĐÂY
            onRefresh: () async {
              // Logic onRefresh bây giờ sẽ đọc state từ BLoC
              // để đảm bảo gửi đúng các filter hiện tại
              final state = context.read<TransactionListBloc>().state;
              context.read<TransactionListBloc>().add(
                TransactionsRefreshed(
                  parkingStatus: state.parkingStatus,
                  plateNumber: state.plateNumber,
                  transactionStatus: state.transactionStatus,
                  expiredParking: state.expiredParking,
                ),
              );
            },
            child: BlocBuilder<TransactionListBloc, TransactionListState>(
              builder: (context, state) {
                print(
                  "--- BlocBuilder is building with Status: ${state.status}, Transaction Count from STATE: ${state.transactions.length} ---",
                );
                switch (state.status) {
                  case TransactionListStatus.failure:
                    // Bây giờ màn hình lỗi cũng có thể kéo để refresh
                    // Để kéo hoạt động tốt hơn trên màn hình không scroll được,
                    // ta bọc nó trong một ListView
                    return ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Center(
                            child: Text(
                              'Lỗi tải dữ liệu: ${state.errorMessage}',
                            ),
                          ),
                        ),
                      ],
                    );
                  case TransactionListStatus.initial:
                    return const Center(child: CircularProgressIndicator());
                  case TransactionListStatus.loading:
                  case TransactionListStatus.success:
                    if (state.transactions.isEmpty &&
                        state.status == TransactionListStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    // Gọi hàm build list như cũ
                    return _buildTransactionList(state);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  // 3. NotificationListener xử lý cuộn một cách an toàn
  // Widget _buildTransactionList(TransactionListState state) {
  //   // return RefreshIndicator(
  //   //   onRefresh: () async {
  //   //     context.read<TransactionListBloc>().add(
  //   //           TransactionsRefreshed(
  //   //             parkingStatus: state.parkingStatus,
  //   //             plateNumber: state.plateNumber,
  //   //             transactionStatus: state.transactionStatus,
  //   //             expiredParking: state.expiredParking,
  //   //           ),
  //   //         );
  //   //   },
  //   //   child: Container(

  //      return Container(decoration: const BoxDecoration(
  //         color: Color(-789258),
  //         borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
  //       ),
  //       child: ClipRRect(
  //         borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
  //         child: NotificationListener<ScrollNotification>(
  //           onNotification: (notification) {
  //             final metrics = notification.metrics;
  //             if (metrics.pixels >= metrics.maxScrollExtent * 0.9) {
  //               final currentState = context.read<TransactionListBloc>().state;

  //             if (!currentState.hasReachedMax && !_isFetching) {

  //               // BƯỚC 1: "NGẮT CẦU CHÌ" -> Ngăn các event tiếp theo
  //               setState(() {
  //                 _isFetching = true;
  //               });

  //               // BƯỚC 2: Gửi event đi
  //               context.read<TransactionListBloc>().add(TransactionsFetched());
  //             }
  //           }
  //           return false;
  //         },
  //           child: ListView.builder(
  //             itemCount: state.transactions.length + 2,
  //             itemBuilder: (context, index) {
  //               if (index == 0) return _buildFilterSection(state);
  //               if (index <= state.transactions.length) {
  //                 final transaction = state.transactions[index - 1];
  //                 print("--- UI is building car card for INDEX: ${index - 1}, Plate: ${transaction.plateNumber} ---");
  //                 return Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //                   child: _buildCarCard(transaction),
  //                 );
  //               }
  //               if (state.hasReachedMax && state.transactions.isEmpty) {
  //                 return Padding(
  //                   padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
  //                   child: const Center(child: Text('Không có giao dịch nào.')),
  //                 );
  //               }
  //               if (!state.hasReachedMax) {
  //                 return const Padding(
  //                   padding: EdgeInsets.symmetric(vertical: 16.0),
  //                   child: Center(child: CircularProgressIndicator()),
  //                 );
  //               }
  //               return const SizedBox.shrink();
  //             },
  //           ),
  //         ),
  //       ),
  //   //   ),
  //   // );
  //      );
  // }
  // Thay thế phần _buildTransactionList trong code của bạn
Widget _buildTransactionList(TransactionListState state) {
  return Container(
    decoration: const BoxDecoration(
      color: Color(-789258),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24), 
        topRight: Radius.circular(24)
      ),
    ),
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24), 
        topRight: Radius.circular(24)
      ),
      child: Column(
        children: [
          // 1. FILTER SECTION - CỐ ĐỊNH, KHÔNG REBUILD
          _buildFilterSection(state),
          
          // 2. CONTENT SECTION - CHỈ PHẦN NÀY MỚI REBUILD
          Expanded(
            child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  final metrics = notification.metrics;
                  if (metrics.pixels >= metrics.maxScrollExtent * 0.9) {
                    final currentState = context.read<TransactionListBloc>().state;
                    
                    if (!currentState.hasReachedMax && !_isFetching) {
                      setState(() {
                        _isFetching = true;
                      });
                      context.read<TransactionListBloc>().add(TransactionsFetched());
                    }
                  }
                  return false;
                },
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: _buildContentList(state), // ← CHỈ CONTENT NÀY MỚI ANIMATION
                ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Tách riêng content list
Widget _buildContentList(TransactionListState state) {
  return ListView.builder(
    key: ValueKey('content_${state.parkingStatus}_${state.plateNumber}_${state.transactionStatus}'),
    padding: EdgeInsets.zero, // Bỏ padding mặc định
    itemCount: state.transactions.length + 1, // +1 cho loading indicator cuối
    itemBuilder: (context, index) {
      // Không còn filter section ở đây nữa
      if (index < state.transactions.length) {
        final transaction = state.transactions[index];
        print("--- UI is building car card for INDEX: $index, Plate: ${transaction.plateNumber} ---");
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: _buildCarCard(transaction),
        );
      }
      
      // Loading indicator cuối list (pagination)
      if (state.hasReachedMax && state.transactions.isEmpty) {
        return Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
          child: const Center(child: Text('Không có giao dịch nào.')),
        );
      }
      if (!state.hasReachedMax) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Center(child: CircularProgressIndicator()),
        );
      }
      return const SizedBox.shrink();
    },
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
          if (_isFilterExpanded) _buildAdvancedFilters(state),
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
              label:
                  'Tất cả ${state.parkingStatus == null ? '(${state.totalCount})' : ''}',
              isSelected: state.parkingStatus == null,
              onTap: () {
                // ================== LOGGING HERE ==================
                print("\n👆 Bấm nút 'Tất cả'.");
                print("   - Trạng thái BLoC *TRƯỚC KHI* gửi event:");
                print(
                  "     -> state.parkingStatus hiện tại là: ${state.parkingStatus}",
                );

                // Gửi event đi mà không cần điều kiện if
                context.read<TransactionListBloc>().add(
                  const TransactionsRefreshed(parkingStatus: null),
                );
                print(
                  "   ✅ Đã gửi event: TransactionsRefreshed(parkingStatus: null)",
                );
                print("-------------------------------------------------");
                // ==================================================
              },
            ),
            _buildFilterChipTest(
              label:
                  'Xe trong bãi ${state.parkingStatus == 1 ? '(${state.totalCount})' : ''}',
              isSelected: state.parkingStatus == 1,
              onTap: () {
                // ================== LOGGING HERE ==================
                print("\n👆 Bấm nút 'Xe trong bãi'.");
                print(
                  "   - State hiện tại (trước khi check): state.parkingStatus = ${state.parkingStatus}",
                );

                if (state.parkingStatus != 1) {
                  print(
                    "   ✅ Điều kiện (state.parkingStatus != 1) là TRUE. Gửi event...",
                  );
                  context.read<TransactionListBloc>().add(
                    const TransactionsRefreshed(parkingStatus: 1),
                  );
                } else {
                  print(
                    "   ❌ Điều kiện (state.parkingStatus != 1) là FALSE. KHÔNG gửi event.",
                  );
                }
                print("-------------------------------------------------");
                // ==================================================
              },
            ),
            _buildFilterChipTest(
              label:
                  'Đã ra ${state.parkingStatus == 2 ? '(${state.totalCount})' : ''}',
              isSelected: state.parkingStatus == 2,
              onTap: () {
                // ================== LOGGING HERE ==================
                print("\n👆 Bấm nút 'Đã ra'.");
                print(
                  "   - State hiện tại (trước khi check): state.parkingStatus = ${state.parkingStatus}",
                );

                if (state.parkingStatus != 2) {
                  print(
                    "   ✅ Điều kiện (state.parkingStatus != 2) là TRUE. Gửi event...",
                  );
                  context.read<TransactionListBloc>().add(
                    const TransactionsRefreshed(parkingStatus: 2),
                  );
                } else {
                  print(
                    "   ❌ Điều kiện (state.parkingStatus != 2) là FALSE. KHÔNG gửi event.",
                  );
                }
                print("-------------------------------------------------");
                // ==================================================
              },
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildAdvancedFilters(TransactionListState state) {
  void _refreshWithNewFilters({
    int? payment,
    String? expired,
  }) {
    context.read<TransactionListBloc>().add(
      TransactionsRefreshed(
        parkingStatus: state.parkingStatus,
        plateNumber: state.plateNumber,
        transactionStatus: payment,
        expiredParking: expired,
      ),
    );
  }

  return Container(
    decoration: BoxDecoration(
      color: const Color(-1),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey),
    ),
    // GIẢI PHÁP 1: Giới hạn chiều cao tối đa
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.4, // Tối đa 40% màn hình
    ),
    child: SingleChildScrollView( // GIẢI PHÁP 2: Cho phép scroll trong filter
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Giảm padding
        child: Column(
          mainAxisSize: MainAxisSize.min, // QUAN TRỌNG: Chỉ chiếm space cần thiết
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bộ lọc nâng cao',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8), // Giảm spacing
            
            // Section 1: Thanh toán
            const Text('Thanh toán', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 6),
            _buildCompactFilterRow(
              filters: [
                ('Tất cả', state.transactionStatus == null, () => _refreshWithNewFilters(payment: null, expired: state.expiredParking)),
                ('Đã thanh toán', state.transactionStatus == 1, () => _refreshWithNewFilters(payment: 1, expired: state.expiredParking)),
                ('Chưa thanh toán', state.transactionStatus == 0, () => _refreshWithNewFilters(payment: 0, expired: state.expiredParking)),
              ],
            ),
            
            const SizedBox(height: 10), // Giảm spacing
            
            // Section 2: Thời gian gửi xe
            const Text('Thời gian gửi xe', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 6),
            _buildCompactFilterRow(
              filters: [
                ('Tất cả', state.expiredParking == null, () => _refreshWithNewFilters(payment: state.transactionStatus, expired: null)),
                ('Quá hạn', state.expiredParking == 'EXPIRED', () => _refreshWithNewFilters(payment: state.transactionStatus, expired: 'EXPIRED')),
                ('Chưa quá hạn', state.expiredParking == 'NOT_EXPIRED', () => _refreshWithNewFilters(payment: state.transactionStatus, expired: 'NOT_EXPIRED')),
              ],
            ),
            
            const SizedBox(height: 12), // Giảm bottom spacing
          ],
        ),
      ),
    ),
  );
}

// Widget compact cho filter row
Widget _buildCompactFilterRow({
  required List<(String, bool, VoidCallback)> filters,
}) {
  return Row(
    children: filters.map((filter) {
      final (label, isSelected, onTap) = filter;
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: _buildCompactFilterChip(
            label: label,
            isSelected: isSelected,
            onTap: onTap,
          ),
        ),
      );
    }).toList(),
  );
}

// Compact filter chip với height cố định
Widget _buildCompactFilterChip({
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 32, // CHIỀU CAO CỐ ĐỊNH - không bị thay đổi
      decoration: BoxDecoration(
        color: isSelected ? const Color(-12877066) : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(-11840157),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 11, // Font nhỏ hơn
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    ),
  );
}

  // Widget _buildFilterChip({
  //   required String label,
  //   required bool isSelected,
  //   required VoidCallback onTap,
  //   bool isPrimary = false,
  // }) {
  //   double totalPadding = 22;
  //   double chipWidth =
  //       (MediaQuery.of(context).size.width - totalPadding * 2.66) / 3;

  //   return SizedBox(
  //     width: chipWidth,
  //     child: ChoiceChip(
  //       padding: const EdgeInsets.all(0),
  //       label: Center(child: Text(label, textAlign: TextAlign.center)),
  //       selected: isSelected,
  //       onSelected: (_) => onTap(),
  //       backgroundColor: Colors.grey[200],
  //       labelPadding: const EdgeInsets.symmetric(horizontal: 4),
  //       selectedColor: isPrimary
  //           ? const Color(-12877066)
  //           : const Color(-789258),
  //       labelStyle: TextStyle(
  //         color: isSelected && isPrimary
  //             ? Colors.white
  //             : const Color(-11840157),
  //         fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
  //         fontSize: 12,
  //       ),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //       showCheckmark: false,
  //     ),
  //   );
  // }

  Widget _buildFilterChipTest({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.1 * 255).toInt()),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected
                  ? const Color(-14326805)
                  : const Color(-11840157),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCarCard(Transaction transaction) {
    final isPaid = transaction.transactionStatus;
    final isOverdue = transaction.expiredParking;
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
                        transaction.plateNumber,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: Color(-15656921),
                        ),
                      ),
                      _buildStatusChip(
                        text: isPaid == 1 ? 'Đã thanh toán' : 'Chưa thanh toán',
                        color: isPaid == 1
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
                            : 'Tiền mặt',
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
                        isOverdue == "EXPIRED"
                            ? 'Quá thời gian'
                            : 'Còn thời gian',
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
                            formattedTime,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            formattedDate,
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
                        '$formattedFee đ',
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
                          color: const Color(-789258),
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
      padding: const EdgeInsets.all(4),
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
