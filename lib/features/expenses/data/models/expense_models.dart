import 'package:scanner/features/expenses/domain/entities/expense_entity.dart';

class ExpenseModels {
  final String id;
  final String merchant;
  final int total;
  final DateTime date;
  final String imageUrl;

  ExpenseModels({
    required this.date,
    required this.id,
    required this.merchant,
    required this.total,
    required this.imageUrl,
  });

  factory ExpenseModels.fromFirestore(String id, Map<String, dynamic> json) {
    return ExpenseModels(
      date: DateTime.parse(json['date']),
      id: id,
      merchant: json['merchant'] as String,
      total: json['total'] as int,
      imageUrl: json['imageUrl'] as String,
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      'date': date.toIso8601String(),
      'merchant': merchant,
      'total': total,
      'imageUrl': imageUrl,
    };
  }

  ExpenseEntity toEntity() {
    return ExpenseEntity(
      date: date,
      merchant: merchant,
      total: total,
      imageUrl: imageUrl,
    );
  }

  factory ExpenseModels.fromEntity(ExpenseEntity entity, String id) {
    return ExpenseModels(
      date: entity.date,
      id: id,
      merchant: entity.merchant,
      total: entity.total,
      imageUrl: entity.imageUrl,
    );
  }
}
