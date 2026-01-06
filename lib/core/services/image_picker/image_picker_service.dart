import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickFromGallery({int imageQuality = 85}) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: imageQuality,
    );

    if (image == null) return null;

    return File(image.path);
  }

  Future<File?> pickFromCamera({int imageQuality = 85}) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: imageQuality,
    );

    if (image == null) return null;

    return File(image.path);
  }
}
