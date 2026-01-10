import 'dart:io';

abstract class TextRecognitionService {
  Future<String> recognize(File image);
}
