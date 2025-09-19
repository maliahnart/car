import 'package:car/constants/custom_color.dart';
import 'package:car/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'list_car_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  // int _selectedIndex = 0;
  // final List<Widget> _pages = [
  //   HomeScreen(),
  //   ListCarScreen(),
  //   SettingsScreen(),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(-1050881),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(-1050881), Color(-1)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              _buildBody(),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: _buildBottomNavbar(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16.0,
        left: 16.0,
        right: 16.0,
        bottom: 24.0,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF9333EA)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(2),
                    child: Image.asset(
                      "assets/images/happy_hand.png",
                      width: 20,
                      height: 20,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Xin chào!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/images/Bell.png'),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0xFF7E34F0)
                    ),
                    child: IconButton(
                      onPressed: () {
                        context.go('/login');
                      },
                      icon: Image.asset('assets/images/Logout Rounded Left.png'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Hôm nay, Thứ Tư, 3 tháng 9, 2025',
            style: TextStyle(color: Colors.white,
            fontSize: 14),
          ),
          const SizedBox(height: 16),
          _buildInfoCard(
            imagePath: 'assets/images/car_icon.png',
            title: 'Xe đang đỗ',
            value: '123',
            label: 'Hôm nay',
            color: Color(0xFFF46841),
          ),
          const SizedBox(height: 12),
          _buildInfoCard(
            imagePath: 'assets/images/money_icon.png',
            title: 'Doanh thu',
            value: '123.456.789đ',
            label: 'Hôm nay',
            color: Color(0xFF1BBEA4),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String imagePath,
    required String title,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 17, right: 17,top: 10,bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha((0.25 * 255).toInt()),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          IconRounded(color: color,imagePath: imagePath,),
          const SizedBox(width: 16,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              Text(title, style: const TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          ),
          const Spacer(),
          Text(label, style: TextStyle(color: Colors.white70,fontSize: 12),)
        ],
      ),
    );
  }

  Widget _buildBody(){
    return Padding(padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tính năng', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
        const SizedBox(height: 16,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildFeatureCard(imagePath: 'assets/images/camera_icon.png', label: 'Check-in',color: Color(-1050881)),
            _buildFeatureCard(imagePath: 'assets/images/qr_icon.png', label: 'Check-out',color: Color(-2067)),
            _buildFeatureCard(imagePath: 'assets/images/Chart Bar.png', label: 'Thống kê', color: Color(-330241)),
          ],
        ),
        const SizedBox(height: 24,),
        const Text('Danh sách xe trong bãi', style: TextStyle(fontWeight: FontWeight.bold,
        fontSize: 14),),
        const SizedBox(height: 16,),
        _buildSearchBar(),
        const SizedBox(height: 40,),
        _buildEmptyState(),
      ],
    ),);
  }

  Widget _buildFeatureCard({required String imagePath, required String label, required Color color}){
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha((0.1*255).toInt()),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0,5),
              )
            ],
          ),
          child: Column(
            children: [
              IconRounded(color: color, imagePath: imagePath),
              const SizedBox(height: 8,),
              Text(label,style: TextStyle(color: Color(-13156015),fontSize: 14),)
            ],
          ),

        ),
      ],
    );
  }

  Widget _buildSearchBar(){
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Tìm kiếm theo biển số...',
        hintStyle: TextStyle(color: Colors.grey[500]),
          suffixIcon: Padding(
            padding: EdgeInsets.all(2),
            child: Image.asset(
              "assets/images/search_icon.png",
              width: 20,
              height: 20,
            ),
          ),
        filled: true,
        fillColor: Color(-986381),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey[300]!)
        )
      ),

    );
  }
  // Widget  _buildBottomNavbar(){
  //   return Scaffold(
  //     body: IndexedStack(
  //       index: _selectedIndex,
  //       children: _pages,
  //     ),
  //      bottomNavigationBar: BottomNavigationBar(
  //       type: BottomNavigationBarType.fixed,
  //         selectedItemColor: CustomColor.primaryBlue,
  //         unselectedItemColor: Colors.grey[600],
  //         backgroundColor: Colors.white,
  //         elevation: 5.0,
  //         currentIndex: 0,
  //         items: [
  //           BottomNavigationBarItem(
  //             icon: Image.asset('assets/images/home_icon_active.png',color: Colors.grey,),
  //             activeIcon:Image.asset('assets/images/home_icon_active.png'),
  //             label: 'Trang chủ',
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Image.asset('assets/images/list_car.png',color: Colors.grey,),
  //             activeIcon: Image.asset('assets/images/list_car.png',color: Colors.blue,),
  //             label: 'Danh sách xe',
  //           ),
  //           const BottomNavigationBarItem(
  //             icon: Icon(Icons.settings_outlined),
  //             activeIcon: Icon(Icons.settings),
  //             label: 'Cài đặt',
  //           ),
  //     ],),
  //   );
  // }
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        children: [
          // Icon(Icons.directions_car_outline, size: 60, color: Colors.grey[400]),
          Container( padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
            color: Color(-789258),
            borderRadius: BorderRadius.circular(40),
          ),
              child: Image.asset('assets/images/car_icon_reverse.png')),
          const SizedBox(height: 16),
          const Text('Chưa có giao dịch nào', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 8),
          Text(
            'Bãi đậu xe trống chưa có phương tiện đậu bên trong',
            style: TextStyle(color: Colors.grey[600],fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
class IconRounded extends StatelessWidget {
  final Color color;
  final String imagePath;

  const IconRounded({
    super.key,
    required this.color,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(
        imagePath,
        width: 24,
        height: 24,
        fit: BoxFit.contain,
      ),
    );
  }

}
