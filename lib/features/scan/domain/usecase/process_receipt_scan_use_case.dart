import 'dart:io';
import '../entities/scan_result_entity.dart';
import '../repositories/receipt_scan_repository.dart';

class ProcessReceiptScanUseCase {
  final ReceiptScanRepository repository;

  ProcessReceiptScanUseCase(this.repository);

  Future<ScanResultEntity> call(File image) {
    return repository.processScan(image);
  }
}
