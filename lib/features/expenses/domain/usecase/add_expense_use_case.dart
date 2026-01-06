import 'package:scanner/features/expenses/domain/entities/expense_entity.dart';
import 'package:scanner/features/expenses/domain/repositories/expense_repository.dart';

class AddExpenseUseCase {
  final ExpenseRepository repository;

  AddExpenseUseCase(this.repository);

  Future<void> call({
    required String userId,
    required int total,
    required DateTime date,
    required String merchant,
    required String imageUrl
  }) {
    final expense = ExpenseEntity(date: date, merchant: merchant, total: total, imageUrl: imageUrl);
    return repository.addExpense(userId, expense);
  }
}
