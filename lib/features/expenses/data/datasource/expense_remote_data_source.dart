import 'package:scanner/features/expenses/data/models/expense_models.dart';

abstract class ExpenseRemoteDataSource {
  Future<ExpenseModels> addExpense(String userId, ExpenseModels expense);
  Future<List<ExpenseModels>> getAllExpense(String userId);
  Future<void> deleteExpense(String userId, String id);
}
