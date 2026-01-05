import 'package:scanner/features/reminder/domain/repositories/task_repository.dart';

class CompletedTaskUseCase {
  final TaskRepository repository;
  CompletedTaskUseCase(this.repository);
  Future<void> call(String userId, String id, bool isCompleted) {
    return repository.completedTask(userId, id, isCompleted);
  }
}
