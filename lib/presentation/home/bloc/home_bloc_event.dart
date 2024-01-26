part of 'home_bloc_bloc.dart';

@immutable
sealed class HomeBlocEvent {}

class HomeChangeScreenEvent extends HomeBlocEvent {
  final int index;

  HomeChangeScreenEvent({required this.index});
}
