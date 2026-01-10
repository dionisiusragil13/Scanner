import '../models/recognized_receipt_data.dart';

class EntityRecognitionService {
  Future<RecognizedReceiptData> extract(String text) async {
    return RecognizedReceiptData(
      merchant: _extractMerchant(text),
      total: _extractTotal(text),
      date: _extractDate(text),
    );
  }

  /// MERCHANT = alamat / nama toko
  String _extractMerchant(String text) {
    final lines = text.split('\n');

    return lines.firstWhere(
      (line) => line.trim().isNotEmpty,
      orElse: () => 'Unknown Merchant',
    );
  }

  /// TOTAL = currency (rupiah)
  int _extractTotal(String text) {
    final regex = RegExp(
      r'(total|jumlah|grand total)\D*([0-9]{1,3}([.,][0-9]{3})+)',
      caseSensitive: false,
    );

    final match = regex.firstMatch(text);
    if (match == null) return 0;

    return int.parse(
      match.group(2)!
          .replaceAll('.', '')
          .replaceAll(',', ''),
    );
  }

  /// DATE = tanggal transaksi
  DateTime _extractDate(String text) {
    final regex = RegExp(
      r'(\d{2}[/-]\d{2}[/-]\d{4})',
    );

    final match = regex.firstMatch(text);
    if (match == null) return DateTime.now();

    final parts = match.group(1)!.split(RegExp(r'[/-]'));

    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }
}
