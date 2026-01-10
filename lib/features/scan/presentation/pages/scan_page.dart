import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/core/di/injection_container.dart';
import 'package:scanner/core/services/image_picker/image_picker_service.dart';
import 'package:scanner/features/scan/domain/usecase/process_receipt_scan_use_case.dart';
import 'package:scanner/features/scan/presentation/controller/scan_camera_controller.dart';
import 'package:scanner/features/scan/presentation/widgets/bottom_icon_button.dart';
import 'package:scanner/features/scan/presentation/widgets/camera_preview_box.dart';
import 'package:scanner/features/scan/presentation/widgets/capture_button.dart';
import 'package:scanner/features/scan/presentation/widgets/circle_button.dart';
import 'package:scanner/features/scan/presentation/widgets/receipt_result_bottom_sheet.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final ScanCameraController _cameraController = ScanCameraController();
  final ImagePickerService _imagePickerService = ImagePickerService();

  File? _image;
  bool _isProcessing = false;

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

  Future<void> _onConfirm() async {
    if (_image == null || _isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      final processReceiptScanUseCase = sl<ProcessReceiptScanUseCase>();

      final scanResult = await processReceiptScanUseCase(_image!);

      if (!mounted) return;

      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) => ReceiptResultBottomSheet(scanResult: scanResult),
      );
    } catch (e) {
      debugPrint('Scan error: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal memproses struk, coba lagi')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  // ignore: unused_element
  void _onSave() {
    // simpan di expense collection
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffffff0),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 45),

              /// Top Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleButton(
                      icon:
                          _cameraController.isFlashOn
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
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                'Position receipt within the frame',
                style: TextStyle(fontSize: 14, color: Colors.black54),
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
                    BottomIconButton(icon: Icons.check, onTap: _onConfirm),
                  ],
                ),
              ),
            ],
          ),

          /// 🔥 INI POSISINYA (PALING BAWAH)
          if (_isProcessing)
            const Positioned.fill(
              child: ColoredBox(
                color: Colors.black38,
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }
}
