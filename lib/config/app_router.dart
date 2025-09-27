import 'package:camera/camera.dart';
import 'package:car/config/state/parking_lot_bloc.dart';
import 'package:car/config/transaction_state/transaction_list_bloc.dart';
import 'package:car/config/transaction_state/transaction_list_event.dart';
import 'package:car/models/parking_lot.dart';
import 'package:car/screens/camera_screen.dart';
import 'package:car/screens/check_in_car.dart';
import 'package:car/screens/choose_parking.dart';
import 'package:car/screens/create_transaction.dart';
import 'package:car/screens/list_car_screen.dart';
import 'package:car/screens/home_screen.dart';
import 'package:car/screens/settings_screen.dart';
import 'package:car/screens/login_screen.dart';
import 'package:car/services/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../constants/custom_color.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    // initialLocation: '/choose_parking',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/choose_parking',
        builder: (context, state) => const ChooseParking(),
      ),
      GoRoute(
        path: '/check_in_car',
        builder: (context, state) {
          return CheckInCar();
        },
      ),
      GoRoute(
      path: '/camera', // Định nghĩa route cho màn hình camera
      builder: (context, state) => const CameraScreen(),
    ),
      GoRoute(
        path: '/create_transaction',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          final imageFile = data['image'] as XFile?;
          return CreateTransaction(
            capturedImage: imageFile,
          );
        },
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, child) {
          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: child.currentIndex,
              onTap: child.goBranch,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: CustomColor.primaryBlue,
              unselectedItemColor: Colors.grey[600],
              backgroundColor: Colors.white,
              elevation: 5.0,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/home_icon_active.png',
                    color: Colors.grey,
                  ),
                  activeIcon: Image.asset('assets/images/home_icon_active.png'),
                  label: 'Trang chủ',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/list_car.png',
                    color: Colors.grey,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/list_car.png',
                    color: Colors.blue,
                  ),
                  label: 'Danh sách xe',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  activeIcon: Icon(Icons.settings),
                  label: 'Cài đặt',
                ),
              ],
            ),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) {
          return HomeScreen();
        },
                
                // routes: [
                //   GoRoute(
                //     path: 'list_car',
                //     builder: (context, state) => const ListCarScreen(),
                //   ),
                // ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/list_car',
                builder: (context, state) {
                  final selectedLotId = context.read<ParkingLotBloc>().state.selectedParkingLot?.id;

                  if (selectedLotId == null) {
                    return const Scaffold(
                      body: Center(
                        child: Text(
                          "Lỗi: Vui lòng chọn một bãi đỗ xe trước.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  // 3. Nếu lotId tồn tại, cung cấp BLoC cho màn hình ListCarScreen
                  return BlocProvider(
                    create: (context) => TransactionListBloc(
                      transactionService: TransactionService(),
                      lotId: selectedLotId,
                    ),
                    child: const ListCarScreen(),
                  );
                }
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
