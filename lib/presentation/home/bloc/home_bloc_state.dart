part of 'home_bloc_bloc.dart';

class HomeBlocState {
  final int selectedIndex;

  HomeBlocState({
    this.selectedIndex = 0,
  });

  HomeBlocState copyWith({
    int? selectedIndex,
  }) =>
      HomeBlocState(
        selectedIndex: selectedIndex ?? this.selectedIndex,
      );
}
