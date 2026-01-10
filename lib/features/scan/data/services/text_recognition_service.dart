import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextRecognitionService {
  final TextRecognizer _recognizer = TextRecognizer();

  Future<String> recognize(File image) async {
    final inputImage = InputImage.fromFile(image);
    final result = await _recognizer.processImage(inputImage);
    return result.text;
  }

  void dispose() {
    _recognizer.close();
  }
}
