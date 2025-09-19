import 'package:car/config/token_storage.dart';
import 'package:car/constants/custom_color.dart';
import 'package:car/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _usernameError;
  String? _passwordError;
  bool _rememberMe = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLogin();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  Future<void> _checkLogin() async{
    final token = await TokenStorage.getToken();
    if(token != null && token.isNotEmpty){
      context.go('/home');
    }else{
      context.go('/login');
    }
  }

  // void _login() {
  //   final username = _usernameController.text;
  //   final password = _passwordController.text;
  //   bool isValid = true;
  //   setState(() {
  //     if (username.isEmpty) {
  //       _usernameError = "Vui lòng điền tên đăng nhập";
  //       isValid = false;
  //     } else {
  //       _usernameError = null;
  //     }
  //     if (password.isEmpty) {
  //       _passwordError = "Vui lòng nhập mật khẩu";
  //       isValid = false;
  //     } else {
  //       _passwordError = null;
  //     }
  //   });
  //   if (isValid) {
  //     context.go('/home');
  //   }
  // }
  void _login() async {
    if (!_formKey.currentState!.validate()) {
      print("❌ Form không hợp lệ");
      return;
    }

    final auth = AuthService();
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    // Debug input
    print("👉 Bắt đầu login...");
    print("Username: $username");
    print("Password: $password");
    print("--------------------------");

    try {
      final result = await auth.login(username, password);
      print("Co chay try-catch");

      // Debug response
      print("✅ Kết quả login: $result");

      if (result != null && result['status'] == 200) {
        final token = result['data']['access_token'];
        await TokenStorage.saveToken(token);
        print("➡️ Chuyển sang trang Home");
        context.go('/home');
      } else {
        print("❌ Đăng nhập thất bại - result null");
      }
    } catch (e, stacktrace) {
      print("🔥 Lỗi khi login: $e");
      print(stacktrace);
    }
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Username
          TextFormField(
            controller: _usernameController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Tên đăng nhập',
              hintStyle: TextStyle(
                color: Colors.white.withAlpha((0.9 * 255).toInt()),
              ),
              contentPadding: const EdgeInsets.only(top: 15, left: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(2),
                child: Image.asset(
                  "assets/images/Icon-person.png",
                  width: 20,
                  height: 20,
                ),
              ),
              fillColor: Colors.white.withAlpha((0.3 * 255).toInt()),
              filled: true,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Vui lòng điền tên đăng nhập";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),


          TextFormField(
            controller: _passwordController,
            style: const TextStyle(color: Colors.white),
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Mật khẩu',
              hintStyle: TextStyle(
                color: Colors.white.withAlpha((0.9 * 255).toInt()),
              ),
              contentPadding: const EdgeInsets.only(top: 15, left: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(2),
                child: Image.asset(
                  "assets/images/Icon-lock.png",
                  width: 20,
                  height: 20,
                ),
              ),
              fillColor: Colors.white.withAlpha((0.3 * 255).toInt()),
              filled: true,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Vui lòng nhập mật khẩu";
              }
              if (value.length < 6) {
                return "Mật khẩu phải từ 6 ký tự";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,colors: [
            Color(0xFF1D4CD1),
            Color(0xFF225AE3),
          ])
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildLogo(),
                  const SizedBox(height: 24),
                  const Text(
                    'Hệ thống thu phí',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Quản lý bãi đỗ xe thông minh',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  // _buildUsernameField(),
                  // const SizedBox(height: 16),
                  // _buildPasswordField(),
                  _buildForm(),
                  const SizedBox(height: 24),
                  _buildLoginButton(CustomColor.primaryBlue),
                  const SizedBox(height: 24),
                  _buildExtraOption(),
                  const SizedBox(height: 200),
                  const Text(
                    'Phiên bản 2.1.0 • © 2024 VDSS Technology',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 120,
        height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withAlpha((0.5*255).toInt()),
      ),
      child: Center(
        child: Image.asset('assets/images/VDSS.png'),
      ),
    );
  }

  // Widget _buildUsernameField() {
  //   return TextField(
  //       controller: _usernameController,
  //       style: const TextStyle(color: Colors.white),
  //       decoration: InputDecoration(
  //         hintText: 'Tên đăng nhập',
  //         hintStyle: TextStyle(
  //           color: Colors.white.withAlpha((0.9 * 255).toInt()),
  //         ),
  //         contentPadding: EdgeInsets.only(top: 15, left: 12),
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //           borderSide: BorderSide.none,
  //         ),
  //         prefixIcon: Padding(
  //           padding: EdgeInsets.all(2),
  //           child: Image.asset(
  //             "assets/images/Icon-person.png",
  //             width: 20,
  //             height: 20,
  //           ),
  //         ),
  //         fillColor: Colors.white.withAlpha((0.3 * 255).toInt()),
  //         // errorText: _usernameError,
  //         filled: true,
  //         // errorStyle: TextStyle(color: Colors.yellowAccent),
  //       ),
  //   );
  // }
  //
  // Widget _buildPasswordField() {
  //   return TextField(
  //     controller: _passwordController,
  //     style: const TextStyle(color: Colors.white),
  //     decoration: InputDecoration(
  //       hintText: 'Mật khẩu',
  //       hintStyle: TextStyle(
  //         color: Colors.white.withAlpha((0.9 * 255).toInt()),
  //       ),
  //       contentPadding: EdgeInsets.only(top: 15, left: 12),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //         borderSide: BorderSide.none,
  //       ),
  //       prefixIcon: Padding(
  //         padding: EdgeInsets.all(2),
  //         child: Image.asset(
  //           "assets/images/Icon-lock.png",
  //           width: 20,
  //           height: 20,
  //         ),
  //       ),
  //       fillColor: Colors.white.withAlpha((0.3 * 255).toInt()),
  //       errorText: _passwordError,
  //       filled: true,
  //       errorStyle: TextStyle(color: Colors.yellowAccent),
  //     ),
  //   );
  // }

  Widget _buildLoginButton(Color color) {
    return ElevatedButton(
      onPressed: _login,
      child: Text(
        'Đăng nhập',
        style: TextStyle(
          color: color,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  Widget _buildExtraOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(value: _rememberMe, onChanged: (value){ setState(() {
                _rememberMe = value ?? false;
              });},
              activeColor: Colors.white,
              checkColor: CustomColor.primaryBlue,
              side: const BorderSide(
                color: Colors.white,
              ),),
            ),
            const SizedBox(width: 8,),
            const Text("Ghi nhớ đăng nhập",
            style: TextStyle(
              color: Colors.white70
            ),)
          ],
        ),
        TextButton(onPressed: (){}, child: const Text("Quên mật khẩu?",
        style: TextStyle(color: Colors.white60,
        decoration: TextDecoration.underline,
        decorationColor: Colors.white),))
      ],
    );
  }
}
