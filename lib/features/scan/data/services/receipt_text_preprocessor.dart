class ReceiptTextPreprocessor {
  String clean(String text) {
    return text
        .replaceAll('\r', '')
        .replaceAll(RegExp(r'\n{2,}'), '\n')
        .trim();
  }
}
