import 'package:scanner/features/auth/domain/entities/user_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final UserEntity user;

  HomeLoaded(this.user);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
