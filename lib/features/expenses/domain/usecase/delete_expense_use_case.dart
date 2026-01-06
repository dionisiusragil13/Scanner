import 'package:scanner/features/expenses/domain/repositories/expense_repository.dart';

class DeleteExpenseUseCase {
  final ExpenseRepository repository;

  DeleteExpenseUseCase(this.repository);

  Future<void> call({required String userId, required String id}) {
    return repository.deleteExpense(userId, id);
  }
}
