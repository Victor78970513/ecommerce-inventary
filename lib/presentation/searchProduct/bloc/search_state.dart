part of 'search_bloc.dart';

class SearchState {
  final String searchName;

  SearchState({required this.searchName});

  SearchState copyWith({String? searchName}) {
    return SearchState(searchName: searchName ?? this.searchName);
  }
}
