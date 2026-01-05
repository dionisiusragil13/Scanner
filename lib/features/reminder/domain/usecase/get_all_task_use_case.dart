import 'package:scanner/features/reminder/domain/entities/task_entity.dart';
import 'package:scanner/features/reminder/domain/repositories/task_repository.dart';

class GetAllTaskUseCase {
  final TaskRepository repository;

  GetAllTaskUseCase(this.repository);

  Future<List<TaskEntity>> call(String userId) {
    return repository.getAllTask(userId);
  }
}
