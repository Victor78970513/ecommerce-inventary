import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState(searchName: "a")) {
    on<OnChangeSearchNameEvent>(onChangeSearchNameEvent);
  }

  FutureOr<void> onChangeSearchNameEvent(
      OnChangeSearchNameEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(searchName: event.newSearch));
  }
}
