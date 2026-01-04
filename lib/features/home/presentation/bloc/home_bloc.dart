import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/features/auth/domain/usecase/get_current_user.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCurrentUser getCurrentUser;

  HomeBloc({required this.getCurrentUser}) : super(HomeInitial()) {
    on<LoadHomeUser>(_onLoadHomeUser);
  }

  Future<void> _onLoadHomeUser(
    LoadHomeUser event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      final user = await getCurrentUser();

      if (user == null) {
        emit(HomeError('User belum login'));
      } else {
        emit(HomeLoaded(user));
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
