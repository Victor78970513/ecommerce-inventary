part of 'category_bloc.dart';

@immutable
class CategoryState {
  final List<Category> categories;
  final bool loadingCategories;
  final bool error;

  final int indexColumn1;
  final int indexColumn2;

  const CategoryState({
    this.categories = const [],
    this.loadingCategories = true,
    this.error = false,
    this.indexColumn1 = 0,
    this.indexColumn2 = 0,
  });

  CategoryState copyWith({
    List<Category>? categories,
    bool? loadingCategories,
    bool? error,
    int? indexColumn1,
    int? indexColumn2,
  }) =>
      CategoryState(
        categories: categories ?? this.categories,
        loadingCategories: loadingCategories ?? this.loadingCategories,
        error: error ?? this.error,
        indexColumn1: indexColumn1 ?? this.indexColumn1,
        indexColumn2: indexColumn2 ?? this.indexColumn2,
      );
}
