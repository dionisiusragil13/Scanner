import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scanner/features/reminder/data/datasource/task_remote_data_source.dart';
import 'package:scanner/features/reminder/data/models/task_models.dart';

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final FirebaseFirestore firestore;

  TaskRemoteDataSourceImpl(this.firestore);

  @override
  Future<TaskModel> addTask(String userId, TaskModel task) async {
    final ref =
        firestore.collection('users').doc(userId).collection('tasks').doc();

    final taskWithId = TaskModel(
      id: ref.id,
      title: task.title,
      date: task.date,
      isCompleted: task.isCompleted,
      isStarred: task.isStarred,
    );

    await ref.set(taskWithId.toFirestore());

    return taskWithId;
  }

  @override
  Future<List<TaskModel>> getAllTask(String userId) async {
    final snapshot =
        await firestore
            .collection('users')
            .doc(userId)
            .collection('tasks')
            .get();

    return snapshot.docs.map((doc) {
      return TaskModel.fromFirestore(doc.id, doc.data());
    }).toList();
  }

  @override
  Future<void> updateStarStatus(String userId, String id, bool isStarred) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(id)
        .update({'isStarred': isStarred});
  }

  @override
  Future<void> completedTask(String userId, String id, bool isCompleted) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(id)
        .update({'isCompleted': isCompleted});
  }

  @override
  Future<void> deleteTask(String userId, String id) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(id)
        .delete();
  }
}
