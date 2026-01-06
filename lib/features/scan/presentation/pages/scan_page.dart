import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scanner/core/services/image_picker/image_picker_service.dart';
import 'package:scanner/features/scan/presentation/controller/scan_camera_controller.dart';
import 'package:scanner/features/scan/presentation/widgets/bottom_icon_button.dart';
import 'package:scanner/features/scan/presentation/widgets/camera_preview_box.dart';
import 'package:scanner/features/scan/presentation/widgets/capture_button.dart';
import 'package:scanner/features/scan/presentation/widgets/circle_button.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final ScanCameraController _cameraController = ScanCameraController();
  final ImagePickerService _imagePickerService = ImagePickerService();

  File? _image;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    await _cameraController.initialize();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _toggleFlash() async {
    await _cameraController.toggleFlash();
    setState(() {});
  }

  Future<void> _pickImageFromGallery() async {
    final image = await _imagePickerService.pickFromGallery();
    if (image == null) return;

    setState(() {
      _image = image;
    });
  }

  Future<void> _onCapture() async {
    final image = await _imagePickerService.pickFromCamera();
    if (image == null) return;

    setState(() {
      _image = image;
    });
  }

  void _onCancel() {
    setState(() {
      _image = null;
    });
  }

  void _onConfirm() {
    if (_image == null) return;

    // NANTI:
    // kirim ke OCR (ML Kit)
    // kirim ke Expense feature
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffffff0),
      body: Column(
        children: [
          const SizedBox(height: 45),

          /// Top Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleButton(
                  icon: _cameraController.isFlashOn
                      ? Icons.flashlight_on
                      : Icons.flashlight_off_outlined,
                  onTap: _toggleFlash,
                ),
                CircleButton(
                  icon: Icons.image_outlined,
                  onTap: _pickImageFromGallery,
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            'Scan Receipt',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Position receipt within the frame',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 30),

          /// Camera Preview
          CameraPreviewBox(
            cameraController: _cameraController.controller,
            isCameraInitialized: _cameraController.isInitialized,
            image: _image,
          ),

          const Spacer(),

          /// Bottom Actions
          Container(
            color: const Color(0xff191970),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BottomIconButton(
                  icon: Icons.cancel_outlined,
                  onTap: _onCancel,
                ),
                CaptureButton(onTap: _onCapture),
                BottomIconButton(
                  icon: Icons.check,
                  onTap: _onConfirm,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
