import 'package:scanner/features/reminder/domain/repositories/task_repository.dart';

class ToggleStarTaskUseCase {
  final TaskRepository repository;

  ToggleStarTaskUseCase(this.repository);

  Future<void> call({
    required String userId,
    required String taskId,
    required bool isStarred,
  }) {
    return repository.updateStarStatus(
      userId,
      taskId,
      isStarred,
    );
  }
}
