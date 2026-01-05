import 'package:scanner/features/reminder/data/models/task_models.dart';

abstract class TaskRemoteDataSource {
  Future<TaskModel> addTask(String userId, TaskModel task);
  Future<List<TaskModel>> getAllTask(String userId);
  Future<void> updateStarStatus(String userId, String id, bool isStarred);
  Future<void> completedTask(String userId, String id, bool isCompleted);
  Future<void> deleteTask(String userId, String id);
}
