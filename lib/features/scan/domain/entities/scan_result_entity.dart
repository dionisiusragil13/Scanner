class ScanResultEntity {
  final String merchant;   // alamat
  final int total;         
  final DateTime date;  
  final String imageUrl;   

  ScanResultEntity({
    required this.merchant,
    required this.total,
    required this.date,
    required this.imageUrl,
  });
}
