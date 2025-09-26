import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with WidgetsBindingObserver {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // Quan trọng: Giải phóng controller khi widget bị dispose.
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;

    // Kiểm tra nếu controller không tồn tại hoặc chưa khởi tạo.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    // Khi ứng dụng không hoạt động, giải phóng controller.
    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Khi ứng dụng hoạt động trở lại, khởi tạo lại camera.
      _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      print("Không tìm thấy camera nào.");
      if (mounted) context.pop();
      return;
    }
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
      enableAudio: false, // Tắt ghi âm
    );

    _initializeControllerFuture = _controller!.initialize();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _takePicture() async {
    try {
      // Đảm bảo camera đã được khởi tạo.
      await _initializeControllerFuture;

      if (_controller == null || !_controller!.value.isInitialized) {
        return;
      }
      
      // Chặn việc chụp nhiều ảnh cùng lúc.
      if (_controller!.value.isTakingPicture) {
        return;
      }

      final XFile image = await _controller!.takePicture();

      // Nếu chụp thành công, đóng màn hình này và trả ảnh về màn hình trước đó.
      if (mounted) {
        context.pop(image);
      }
    } catch (e) {
      print("Lỗi khi chụp ảnh: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Chụp Ảnh', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: CameraPreview(_controller!),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        backgroundColor: Colors.white,
        child: const Icon(Icons.camera_alt, color: Colors.black),
      ),
    );
  }
}