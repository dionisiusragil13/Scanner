class RecognizedReceiptData {
  final String merchant;
  final int total;
  final DateTime date;

  RecognizedReceiptData({
    required this.merchant,
    required this.total,
    required this.date,
  });
}
