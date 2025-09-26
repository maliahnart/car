import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// State của widget này cần được truy cập từ bên ngoài, nên ta định nghĩa nó riêng.
class CameraPreviewWidgetState extends State<CameraPreviewWidget> {
  CameraController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        print("Không tìm thấy camera.");
        if (widget.onCameraError != null) {
          widget.onCameraError!("Không tìm thấy camera.");
        }
        return;
      }

      _controller = CameraController(
        cameras.first,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _controller!.initialize();

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
        // Báo cho widget cha rằng camera đã sẵn sàng
        if (widget.onCameraReady != null) {
          widget.onCameraReady!();
        }
      }
    } catch (e) {
      print("Lỗi khởi tạo camera: $e");
      if (widget.onCameraError != null) {
        widget.onCameraError!(e.toString());
      }
    }
  }

  // HÀM PUBLIC: Widget cha sẽ gọi hàm này thông qua GlobalKey
  Future<XFile?> takePicture() async {
    if (!_isInitialized || _controller == null || _controller!.value.isTakingPicture) {
      return null;
    }
    try {
      final XFile imageFile = await _controller!.takePicture();
      return imageFile;
    } catch (e) {
      print("Lỗi khi chụp ảnh: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized || _controller == null) {
      // Hiển thị loading trong khi chờ camera
      return const Center(child: CircularProgressIndicator());
    }
    // Khi đã sẵn sàng, hiển thị camera preview
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CameraPreview(_controller!),
    );
  }
}

// Đây là StatefulWidget mà màn hình CheckInCar sẽ sử dụng
class CameraPreviewWidget extends StatefulWidget {
  final VoidCallback? onCameraReady;
  final Function(String)? onCameraError;

  const CameraPreviewWidget({
    Key? key,
    this.onCameraReady,
    this.onCameraError,
  }) : super(key: key);

  @override
  CameraPreviewWidgetState createState() => CameraPreviewWidgetState();
}