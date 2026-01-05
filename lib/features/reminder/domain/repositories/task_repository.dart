import 'package:scanner/features/reminder/domain/entities/task_entity.dart';

abstract class TaskRepository {
  Future<TaskEntity> addTask(String userId, TaskEntity task);
  Future<List<TaskEntity>> getAllTask(String userId);
  Future<void> updateStarStatus(String userId, String taskId, bool isStarred);
  Future<void> completedTask(String userId, String id, bool isCompleted);
  Future<void> deleteTask(String userId, String id);
}
