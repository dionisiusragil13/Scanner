abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String title;
  final DateTime date;
  AddTaskEvent({required this.date, required this.title});
}

class ToggleStarTask extends TaskEvent {
  final String id;
  final bool isStarred;
  ToggleStarTask({required this.isStarred, required this.id});
}

class CompleteTaskEvent extends TaskEvent {
  final String id;
  CompleteTaskEvent({required this.id});
}

class DeleteTaskEvent extends TaskEvent {
  final String id;
  DeleteTaskEvent({required this.id});
}
