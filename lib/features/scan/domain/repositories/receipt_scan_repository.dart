import 'dart:io';
import '../entities/scan_result_entity.dart';

abstract class ReceiptScanRepository {
  Future<ScanResultEntity> processScan(File image);
}
