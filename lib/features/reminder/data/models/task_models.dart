import 'package:scanner/features/reminder/domain/entities/task_entity.dart';

class TaskModel {
  final String id;
  final String title;
  final DateTime date;
  final bool isCompleted;
  final bool isStarred;

  TaskModel({
    required this.id,
    required this.title,
    required this.date,
    required this.isCompleted,
    required this.isStarred,
  });

  /// Firestore → Model
  factory TaskModel.fromFirestore(
    String id,
    Map<String, dynamic> json,
  ) {
    return TaskModel(
      id: id,
      title: json['title'] as String,
      date: DateTime.parse(json['date']),
      isCompleted: json['isCompleted'] as bool,
      isStarred: json['isStarred'] as bool,
    );
  }

  /// Model → Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'date': date.toIso8601String(),
      'isCompleted': isCompleted,
      'isStarred': isStarred,
    };
  }

  /// Model → Entity
  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      title: title,
      date: date,
      isCompleted: isCompleted,
      isStarred: isStarred,
    );
  }

  /// Entity → Model
  factory TaskModel.fromEntity(TaskEntity entity, String id) {
    return TaskModel(
      id: id,
      title: entity.title,
      date: entity.date,
      isCompleted: entity.isCompleted,
      isStarred: entity.isStarred,
    );
  }
}
