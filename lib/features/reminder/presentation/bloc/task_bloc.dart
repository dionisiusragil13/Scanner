import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/features/auth/domain/usecase/get_current_user.dart';
import 'package:scanner/features/reminder/domain/usecase/add_task_use_case.dart';
import 'package:scanner/features/reminder/domain/usecase/completed_task_use_case.dart';
import 'package:scanner/features/reminder/domain/usecase/delete_task_use_case.dart';
import 'package:scanner/features/reminder/domain/usecase/get_all_task_use_case.dart';
import 'package:scanner/features/reminder/domain/usecase/toggle_star_task_use_case.dart';
import 'package:scanner/features/reminder/presentation/bloc/task_event.dart';
import 'package:scanner/features/reminder/presentation/bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AddTaskUseCase addTaskUseCase;
  final GetAllTaskUseCase getAllTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final ToggleStarTaskUseCase toggleStarTaskUseCase;
  final CompletedTaskUseCase completedTaskUseCase;
  final GetCurrentUser getCurrentUser;
  final LoadTasks loadTasks;

  TaskBloc({
    required this.addTaskUseCase,
    required this.completedTaskUseCase,
    required this.deleteTaskUseCase,
    required this.getAllTaskUseCase,
    required this.toggleStarTaskUseCase,
    required this.getCurrentUser,
    required this.loadTasks,
  }) : super(TaskInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTaskEvent);
    on<CompleteTaskEvent>(_onCompleteTaskEvent);
    on<DeleteTaskEvent>(_onDeleteTaskEvent);
    on<ToggleStarTask>(_onToggleStarTask);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    try {
      emit(TaskLoading());
      final user = await getCurrentUser();

      if (user == null) {
        emit(TaskError("User not loged in"));
        return;
      }

      final task = await getAllTaskUseCase(user.id);
      emit(TaskLoaded(task));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onAddTaskEvent(
    AddTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      emit(TaskLoading());

      final user = await getCurrentUser();

      if (user == null) {
        emit(TaskError('User not logged in'));
        return;
      }

      await addTaskUseCase(
        userId: user.id,
        title: event.title,
        date: event.date,
      );

      final tasks = await getAllTaskUseCase(user.id);
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onCompleteTaskEvent(
    CompleteTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {} catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onDeleteTaskEvent(
    DeleteTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      final user = await getCurrentUser();

      if (user == null) {
        emit(TaskError('user Not Logged in'));
      }

      await deleteTaskUseCase(user!.id, event.id);

      final tasks = await getAllTaskUseCase(user.id);
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onToggleStarTask(
    ToggleStarTask event,
    Emitter<TaskState> emit,
  ) async {
    try {} catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
