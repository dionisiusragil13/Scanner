class TaskEntity {
  final String? id;
  final DateTime date;
  final String title;
  final bool isCompleted;
  final bool isStarred;

  TaskEntity({
    this.id,
    required this.date,
    required this.title,
    this.isCompleted = false,
    this.isStarred = false,
  });
}
