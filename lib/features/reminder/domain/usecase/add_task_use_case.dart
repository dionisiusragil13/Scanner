import 'package:scanner/features/reminder/domain/entities/task_entity.dart';
import 'package:scanner/features/reminder/domain/repositories/task_repository.dart';

class AddTaskUseCase {
  final TaskRepository repository;

  AddTaskUseCase(this.repository);

  Future<void> call({
    required String userId,
    required String title,
    required DateTime date,
  }) {
    final task = TaskEntity(
      title: title,
      date: date,
    );

    return repository.addTask(userId, task);
  }
}
