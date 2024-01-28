part of 'category_bloc.dart';

@immutable
class CategoryState {
  final List<Category> categories;
  final bool loadingCategories;
  final bool error;

  const CategoryState({
    this.categories = const [],
    this.loadingCategories = true,
    this.error = false,
  });

  CategoryState copyWith({
    List<Category>? categories,
    bool? loadingCategories,
    bool? error,
  }) =>
      CategoryState(
        categories: categories ?? this.categories,
        loadingCategories: loadingCategories ?? this.loadingCategories,
        error: error ?? this.error,
      );
}
