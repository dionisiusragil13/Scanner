import 'package:scanner/features/reminder/domain/repositories/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository repository;

  DeleteTaskUseCase(this.repository);
  Future<void> call(String userId, String id) {
    return repository.deleteTask(userId, id);
  }
}
