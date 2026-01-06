import 'package:scanner/features/expenses/domain/entities/expense_entity.dart';

abstract class ExpenseRepository {
  Future<ExpenseEntity> addExpense(String userId, ExpenseEntity expense);
  Future<void> deleteExpense(String userId, String id);
  Future<List<ExpenseEntity>> getAllExpense(String userId);
}
