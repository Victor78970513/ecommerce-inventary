part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class OnChangeSearchNameEvent extends SearchEvent {
  final String newSearch;

  OnChangeSearchNameEvent({required this.newSearch});
}
