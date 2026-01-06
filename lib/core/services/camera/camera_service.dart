// data/datasources/camera_service.dart
import 'package:camera/camera.dart';

class CameraService {
  CameraController? _controller;
  
  Future<CameraController> getCameraController() async {
    if (_controller != null) return _controller!;

    final cameras = await availableCameras();
    _controller = CameraController(
      cameras.first, 
      ResolutionPreset.medium,
      enableAudio: false,
    );
    
    await _controller!.initialize();
    return _controller!;
  }

  void dispose() {
    _controller?.dispose();
  }
}