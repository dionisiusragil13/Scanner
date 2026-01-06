class ExpenseEntity {
  final String? id;
  final int total;
  final DateTime date;
  final String merchant;
  final String imageUrl;

  ExpenseEntity({
    required this.date,
    this.id,
    required this.merchant,
    required this.total,
    required this.imageUrl,
  });
}
