import 'dart:io';

import '../../domain/entities/scan_result_entity.dart';
import '../../domain/repositories/receipt_scan_repository.dart';
import '../services/text_recognition_service.dart';
import '../services/entity_recognition_service.dart';
import '../services/receipt_text_preprocessor.dart';

class ReceiptScanRepositoryImpl implements ReceiptScanRepository {
  final TextRecognitionService textRecognition;
  final EntityRecognitionService entityRecognition;
  final ReceiptTextPreprocessor preprocessor;

  ReceiptScanRepositoryImpl({
    required this.textRecognition,
    required this.entityRecognition,
    required this.preprocessor,
  });

  @override
  Future<ScanResultEntity> processScan(File image) async {
    final rawText = await textRecognition.recognize(image);
    final cleanedText = preprocessor.clean(rawText);
    final recognized = await entityRecognition.extract(cleanedText);

    return ScanResultEntity(
      merchant: recognized.merchant,
      total: recognized.total,
      date: recognized.date,
      imageUrl: image.path,
    );
  }
}
