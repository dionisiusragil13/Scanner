import 'package:scanner/features/expenses/domain/repositories/expense_repository.dart';

class GetAllExpenseUseCase {
  final ExpenseRepository repository;

  GetAllExpenseUseCase(this.repository);

  Future<void> call({required String userId}) {
    return repository.getAllExpense(userId);
  }
}
