// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:car/models/parking_lot.dart'; 
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:permission_handler/permission_handler.dart';

// class CheckInCar extends StatefulWidget {
//   final ParkingLot selectedLot;

//   const CheckInCar({super.key, required this.selectedLot});

//   @override
//   State<CheckInCar> createState() => _CheckInCarState();
// }

// class _CheckInCarState extends State<CheckInCar> with WidgetsBindingObserver {
//   CameraController? _cameraController;
//   List<CameraDescription>? _cameras;
//   XFile? _image;
//   bool _isCameraInitializing = false; 
//   bool _isCameraActive = false;

//   @override
//   void dispose() {
//     _cameraController?.dispose();
//     super.dispose();
//   }

//   Future<void> _initCamera() async {
//     // Xin quyền camera
//     final status = await Permission.camera.request();
//     if (!status.isGranted) {
//       print("Camera permission denied");
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Vui lòng cấp quyền truy cập camera.')),
//       );
//       if (mounted) setState(() => _isCameraInitializing = false);
//       return;
//     }

//     _cameras = await availableCameras();
//     if (_cameras != null && _cameras!.isNotEmpty) {
//       _cameraController = CameraController(
//         _cameras!.first,
//         ResolutionPreset.high,
//       );
//       await _cameraController!.initialize();
//       // Đã khởi tạo xong
//       if (mounted) setState(() => _isCameraInitializing = false);
//     }
//   }

//   Future<void> _activateCamera() async {
//     if (_isCameraActive) return; 

//     setState(() {
//       _isCameraActive = true;
//       _isCameraInitializing = true; // Bắt đầu khởi tạo
//     });

//     await _initCamera(); // Gọi hàm khởi tạo
//   }

//  Future<void> _takePhoto() async {
//   if (_cameraController == null || !_cameraController!.value.isInitialized) {
//     print("Camera is not ready.");
//     return;
//   }

//   if (_cameraController!.value.isTakingPicture) {
//     print("Already taking a picture...");
//     return;
//   }

//   try {
//     final XFile file = await _cameraController!.takePicture();

//     _image = file;
//     print(file.name);
//     print(await file.lastModified());

//     final transactionData = {'lot': widget.selectedLot, 'image': _image};

//     if (mounted) {
//       await context.push('/create_transaction', extra: transactionData);
      
//       await _activateCamera();
//     }
//   } catch (e) {
//     print("Error taking photo: $e");
//   }
// }



//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             onPressed: () {
//               context.pop();
//             },
//             icon: Icon(Icons.arrow_back, color: Colors.white),
//           ),
//           centerTitle: true,
//           toolbarHeight: 70,
//           title: Text(
//             'Chụp Ảnh Phương Tiện',
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
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               children: [
//                 // Widget này bây giờ sẽ có logic hiển thị
//                 _buildCameraDisplay(),
//                 const SizedBox(height: 24),

//                 _buildInstructionsBox(),
//                 const SizedBox(height: 32),
//                 // Nút này bây giờ sẽ vô hiệu hóa nếu camera chưa bật
//                 _buildTakePhotoButton(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCameraDisplay() {
//     if (!_isCameraActive) {
//       return GestureDetector(
//         onTap: _activateCamera,
//         child: _buildCameraPlaceholder(),
//       );
//     }

//     if (_isCameraInitializing) {
//       return Container(
//         height: 200,
//         margin: const EdgeInsets.symmetric(horizontal: 20),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: const CircularProgressIndicator(color: Color(0xFF3B82F6)),
//       );
//     }

//     if (_cameraController != null && _cameraController!.value.isInitialized) {
//       return Container(
//         height: 200,
//         margin: const EdgeInsets.symmetric(horizontal: 20),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withAlpha((0.1 * 255).toInt()),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Stack(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: SizedBox(
//                 height: 200,
//                 width: double.infinity,
//                 child: CameraPreview(_cameraController!),
//               ),
//             ),
//             // Corner borders như trong hình
//             _buildCameraCorners(),
//           ],
//         ),
//       );
//     }

//     return Container(
//       height: 200,
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: const Text("Không thể khởi động camera."),
//     );
//   }

//   Widget _buildCameraPlaceholder() {
//     return Container(
//       height: 200,
//       decoration: BoxDecoration(
//         color: const Color(0xFF1F2937),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Icon(
//                     Icons.camera_alt_outlined,
//                     color: Colors.white,
//                     size: 32,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 const Text(
//                   'Chụp ảnh phương tiện',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 const Text(
//                   'Đảm bảo biển số xe rõ ràng và toàn bộ\nphương tiện trong khung hình',
//                   style: TextStyle(color: Colors.white70, fontSize: 12),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//           // Corner borders
//           _buildCameraCorners(),
//         ],
//       ),
//     );
//   }

//   Widget _buildCameraCorners() {
//     return Positioned.fill(
//       child: Container(
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
//         child: Stack(
//           children: [
//             // Top left corner
//             Positioned(
//               top: 16,
//               left: 16,
//               child: Container(
//                 width: 20,
//                 height: 20,
//                 decoration: const BoxDecoration(
//                   border: Border(
//                     top: BorderSide(color: Colors.white, width: 3),
//                     left: BorderSide(color: Colors.white, width: 3),
//                   ),
//                 ),
//               ),
//             ),
//             // Top right corner
//             Positioned(
//               top: 16,
//               right: 16,
//               child: Container(
//                 width: 20,
//                 height: 20,
//                 decoration: const BoxDecoration(
//                   border: Border(
//                     top: BorderSide(color: Colors.white, width: 3),
//                     right: BorderSide(color: Colors.white, width: 3),
//                   ),
//                 ),
//               ),
//             ),
//             // Bottom left corner
//             Positioned(
//               bottom: 16,
//               left: 16,
//               child: Container(
//                 width: 20,
//                 height: 20,
//                 decoration: const BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(color: Colors.white, width: 3),
//                     left: BorderSide(color: Colors.white, width: 3),
//                   ),
//                 ),
//               ),
//             ),
//             // Bottom right corner
//             Positioned(
//               bottom: 16,
//               right: 16,
//               child: Container(
//                 width: 20,
//                 height: 20,
//                 decoration: const BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(color: Colors.white, width: 3),
//                     right: BorderSide(color: Colors.white, width: 3),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInstructionsBox() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFFEFF6FF), Color(0xFFDBEAFE)],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Color(0xff2563EB),
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withAlpha((0.1 * 255).toInt()),
//                       spreadRadius: 2,
//                       blurRadius: 10,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Image.asset('assets/images/instruction.png'),
//               ),
//               const SizedBox(width: 12),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Hướng dẫn chụp ảnh:',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF1E3A8A),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   _buildInstructionRow(
//                     'Đảm bảo biển số xe rõ',
//                     'ràng, không bị che khuất',
//                   ),
//                   const SizedBox(height: 8),
//                   _buildInstructionRow(
//                     'Ánh sáng đủ để nhận diện',
//                     ' được màu sắc xe',
//                   ),
//                   const SizedBox(height: 8),
//                   _buildInstructionRow(
//                     'Chụp từ góc độ phù hợp để ',
//                     'thấy vị trí đỗ xe',
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInstructionRow(String text1, String text2) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Icon(Icons.check, color: Color(0xFF3B82F6), size: 18),
//         const SizedBox(width: 4),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               text1,
//               style: const TextStyle(color: Color(0xFF1E3A8A), fontSize: 14),
//             ),
//             Text(
//               text2,
//               style: const TextStyle(color: Color(0xFF1E3A8A), fontSize: 14),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildTakePhotoButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton.icon(
//         // Vô hiệu hóa nút nếu camera chưa active hoặc đang khởi tạo
//         onPressed: (_isCameraActive && !_isCameraInitializing)
//             ? _takePhoto
//             : null,
//         icon: const Icon(Icons.camera_alt_outlined, color: Colors.white),
//         label: const Text(
//           'Chụp ảnh',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF2563EB),
//           disabledBackgroundColor: Colors.grey, // Màu khi nút bị vô hiệu hóa
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           elevation: 4,
//         ),
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:camera/camera.dart';
import 'package:car/models/parking_lot.dart';
import 'package:car/widgets/camera_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckInCar extends StatefulWidget {

  const CheckInCar({super.key});

  @override
  State<CheckInCar> createState() => _CheckInCarState();
}

class _CheckInCarState extends State<CheckInCar> {
  final GlobalKey<CameraPreviewWidgetState> _cameraKey = GlobalKey();

  XFile? _image;
  bool _isCameraActive = false;
  bool _isCameraReady = false;

  Future<void> _activateCamera() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      setState(() {
        _isCameraActive = true;
        _image = null; 
        _isCameraReady = false;
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vui lòng cấp quyền truy cập camera.')),
        );
      }
    }
  }

  Future<void> _takePhoto() async {
    final imageFile = await _cameraKey.currentState?.takePicture();
    if (imageFile != null) {
      setState(() {
        _image = imageFile;
        _isCameraActive = false;
      });
    }
  }

  void _confirmAndProceed() {
    if (_image == null) return;

    final transactionData = {'image': _image};
    context.push('/create_transaction', extra: transactionData);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          centerTitle: true,
          toolbarHeight: 70,
          title: const Text(
            'Chụp Ảnh Phương Tiện',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _buildCameraDisplay(),
                const SizedBox(height: 24),
                _buildInstructionsBox(),
                const SizedBox(height: 32),
                _buildActionButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

 Widget _buildCameraDisplay() {
  Widget content;

  if (_image != null) {
    content = Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: _activateCamera,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(File(_image!.path), fit: BoxFit.cover),
            ),
          ),
        ),
        // IconButton(
        //   onPressed: _activateCamera,
        //   icon: const Icon(Icons.refresh, color: Colors.white, size: 40),
        //   style: IconButton.styleFrom(backgroundColor: Colors.black45),
        // ),
      ],
    );
  } else if (_isCameraActive) {
    content = CameraPreviewWidget(
      key: _cameraKey,
      onCameraReady: () {
        Future.microtask(() => setState(() => _isCameraReady = true));
      },
      onCameraError: (error) {
        if (mounted) {
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Lỗi camera: $error")));
           setState(() => _isCameraActive = false);
        }
      },
    );
  } else {
    content = GestureDetector(
      onTap: _activateCamera,
      child: _buildCameraPlaceholder(),
    );
  }

  return Container(
    height: 250,
    width: double.infinity,
    decoration: BoxDecoration(
      color: const Color(0xFF1F2937),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Stack(
      fit: StackFit.expand,
      children: [
        content, 
        Positioned.fill(
          child: _buildCameraCorners(), 
        ),
      ],
    ),
  );
}

  Widget _buildActionButton() {
    bool isPhotoTaken = _image != null;
    String buttonText = isPhotoTaken ? 'Xác nhận' : 'Chụp ảnh';
    IconData buttonIcon = isPhotoTaken ? Icons.check_circle_outline : Icons.camera_alt_outlined;
    bool isButtonEnabled = (_isCameraActive && _isCameraReady) || isPhotoTaken;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: isButtonEnabled
            ? (isPhotoTaken ? _confirmAndProceed : _takePhoto)
            : null,
        icon: Icon(buttonIcon, color: Colors.white),
        label: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2563EB),
          disabledBackgroundColor: Colors.grey,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
        ),
      ),
    );
  }

  Widget _buildCameraPlaceholder() {
    return Container( 
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Nhấn để chụp ảnh phương tiện',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Đảm bảo biển số xe rõ ràng và toàn bộ\nphương tiện trong khung hình',
            style: TextStyle(color: Colors.white70, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

 // SỬA LỖI Ở ĐÂY:
// Widget này không trả về Positioned nữa.
Widget _buildCameraCorners() {
  // Nó trả về IgnorePointer để chặn thao tác chạm.
  return IgnorePointer(
    // Con của nó là Stack chứa các góc.
    child: Stack(
      children: [
        Positioned(top: 16, left: 16, child: _cornerBox(top: true, left: true)),
        Positioned(top: 16, right: 16, child: _cornerBox(top: true, right: true)),
        Positioned(bottom: 16, left: 16, child: _cornerBox(bottom: true, left: true)),
        Positioned(bottom: 16, right: 16, child: _cornerBox(bottom: true, right: true)),
      ],
    ),
  );
}

  Widget _cornerBox({bool top = false, bool bottom = false, bool left = false, bool right = false}) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        border: Border(
          top: top ? const BorderSide(color: Colors.white, width: 3) : BorderSide.none,
          bottom: bottom ? const BorderSide(color: Colors.white, width: 3) : BorderSide.none,
          left: left ? const BorderSide(color: Colors.white, width: 3) : BorderSide.none,
          right: right ? const BorderSide(color: Colors.white, width: 3) : BorderSide.none,
        ),
      ),
    );
  }
  Widget _buildInstructionsBox() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEFF6FF), Color(0xFFDBEAFE)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xff2563EB),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(25),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Image.asset('assets/images/instruction.png', width: 40, height: 40),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hướng dẫn chụp ảnh:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                const SizedBox(height: 12),
                _buildInstructionRow('Đảm bảo biển số xe rõ ràng, không bị che khuất.'),
                const SizedBox(height: 8),
                _buildInstructionRow('Ánh sáng đủ để nhận diện được màu sắc xe.'),
                const SizedBox(height: 8),
                _buildInstructionRow('Chụp toàn bộ phương tiện trong khung hình.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionRow(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle, color: Color(0xFF3B82F6), size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Color(0xFF1E3A8A), fontSize: 13),
          ),
        ),
      ],
    );
  }
}