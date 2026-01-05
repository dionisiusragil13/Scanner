import 'package:scanner/features/reminder/data/datasource/task_remote_data_source.dart';
import 'package:scanner/features/reminder/data/models/task_models.dart';
import 'package:scanner/features/reminder/domain/entities/task_entity.dart';
import 'package:scanner/features/reminder/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remote;

  TaskRepositoryImpl(this.remote);

  @override
  Future<void> deleteTask(String userId, String id) {
    return remote.deleteTask(userId, id);
  }

  @override
  Future<List<TaskEntity>> getAllTask(String userId) async {
    final model = await remote.getAllTask(userId);
    return model.map((model) {
      return model.toEntity();
    }).toList();
  }

  @override
  Future<void> updateStarStatus(String userId, String id, bool isStarred) {
    return remote.updateStarStatus(userId, id, isStarred);
  }

  @override
  Future<void> completedTask(String userId, String id, bool isCompleted) {
    return remote.completedTask(userId, id, isCompleted);
  }

  @override
  Future<TaskEntity> addTask(String userId, TaskEntity task) async {
    final model = TaskModel.fromEntity(task, '');
    final resultModel = await remote.addTask(userId, model);
    return resultModel.toEntity();
  }
}
