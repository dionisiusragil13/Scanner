import 'package:scanner/features/expenses/data/datasource/expense_remote_data_source.dart';
import 'package:scanner/features/expenses/data/models/expense_models.dart';
import 'package:scanner/features/expenses/domain/entities/expense_entity.dart';
import 'package:scanner/features/expenses/domain/repositories/expense_repository.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseRemoteDataSource remote;

  ExpenseRepositoryImpl(this.remote);

  @override
  Future<void> deleteExpense(String userId, String id) {
    return remote.deleteExpense(userId, id);
  }

  @override
  Future<ExpenseEntity> addExpense(String userId, ExpenseEntity expense) async {
    final model = ExpenseModels.fromEntity(expense, '');
    final resultModel = await remote.addExpense(userId, model);
    return resultModel.toEntity();
  }

  @override
  Future<List<ExpenseEntity>> getAllExpense(String userId) async {
    final model = await remote.getAllExpense(userId);
    return model.map((model) {
      return model.toEntity();
    }).toList();
  }
}
