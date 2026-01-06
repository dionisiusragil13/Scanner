import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scanner/features/expenses/data/datasource/expense_remote_data_source.dart';
import 'package:scanner/features/expenses/data/models/expense_models.dart';

class ExpenseRemoteDataSourceImpl implements ExpenseRemoteDataSource {
  final FirebaseFirestore firestore;

  ExpenseRemoteDataSourceImpl(this.firestore);

  @override
  Future<ExpenseModels> addExpense(String userId, ExpenseModels expense) async {
    final ref =
        firestore.collection('users').doc(userId).collection('expenses').doc();

    final expenseWithId = ExpenseModels(
      date: expense.date,
      id: ref.id,
      merchant: expense.merchant,
      total: expense.total,
      imageUrl: expense.imageUrl,
    );

    await ref.set(expenseWithId.toFirestore());
    return expenseWithId;
  }

  @override
  Future<List<ExpenseModels>> getAllExpense(String userId) async {
    final snapshot =
        await firestore
            .collection('users')
            .doc(userId)
            .collection('expenses')
            .get();
    return snapshot.docs.map((doc) {
      return ExpenseModels.fromFirestore(doc.id, doc.data());
    }).toList();
  }

  @override
  Future<void> deleteExpense(String userId, String id) async {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('expenses')
        .doc(id)
        .delete();
  }
}
