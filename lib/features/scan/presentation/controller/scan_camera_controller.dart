import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';

class ScanCameraController with WidgetsBindingObserver {
  CameraController? controller;
  bool isInitialized = false;
  bool isFlashOn = false;
  List<CameraDescription>? cameras;

  Future<void> initialize() async {
    cameras = await availableCameras();

    controller = CameraController(
      cameras!.first,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await controller!.initialize();
    isInitialized = true;
  }

  Future<void> toggleFlash() async {
    if (controller == null) return;

    isFlashOn = !isFlashOn;
    await controller!.setFlashMode(
      isFlashOn ? FlashMode.torch : FlashMode.off,
    );
  }

  void dispose() {
    controller?.dispose();
  }
}
