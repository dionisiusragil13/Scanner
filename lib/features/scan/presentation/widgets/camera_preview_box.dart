import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPreviewBox extends StatelessWidget {
  final CameraController? cameraController;
  final bool isCameraInitialized;
  final File? image;
  final double? width;
  final double? height;

  const CameraPreviewBox({
    super.key,
    required this.cameraController,
    required this.isCameraInitialized,
    this.image,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final boxWidth = width ?? MediaQuery.of(context).size.width * 0.85;
    final boxHeight = height ?? boxWidth * 1.3;

    return Container(
      width: boxWidth,
      height: boxHeight,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    /// PRIORITAS 1 → image hasil capture / gallery
    if (image != null) {
      return Image.file(
        image!,
        fit: BoxFit.cover,
      );
    }

    /// PRIORITAS 2 → kamera
    if (isCameraInitialized && cameraController != null) {
      return Stack(
        fit: StackFit.expand,
        children: [
          CameraPreview(cameraController!),

          Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          Positioned(top: 20, left: 20, child: _buildCorner()),
          Positioned(
            top: 20,
            right: 20,
            child: Transform.rotate(
              angle: 1.5708,
              child: _buildCorner(),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Transform.rotate(
              angle: -1.5708,
              child: _buildCorner(),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Transform.rotate(
              angle: 3.14159,
              child: _buildCorner(),
            ),
          ),
        ],
      );
    }

    /// LOADING
    return const Center(
      child: CircularProgressIndicator(color: Colors.white),
    );
  }

  Widget _buildCorner() {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white, width: 3),
          left: BorderSide(color: Colors.white, width: 3),
        ),
      ),
    );
  }
}
