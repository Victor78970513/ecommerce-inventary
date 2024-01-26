import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBloc() : super(HomeBlocState()) {
    on<HomeChangeScreenEvent>(homeChangeScreen);
  }

  FutureOr<void> homeChangeScreen(HomeChangeScreenEvent event, emit) {
    emit(state.copyWith(selectedIndex: event.index));
    print(state.selectedIndex);
  }
}
