import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:yosyelan_inventary/models/category_model.dart';
import 'package:yosyelan_inventary/repositories/categories/categories_repository.dart';
import 'package:yosyelan_inventary/repositories/categories/categories_repository_imp.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  late CategoriesRepository _categoriesRepository;

  CategoryBloc() : super(const CategoryState()) {
    //
    _categoriesRepository = CategoriesRepositoriesImp();
    //
    on<OnGetCategoriesEvent>(getCategories);
  }

  FutureOr<void> getCategories(
      OnGetCategoriesEvent event, Emitter<CategoryState> emit) async {
    try {
      emit(state.copyWith(loadingCategories: true));
      final resp = await _categoriesRepository.getAllCategories();
      emit(state.copyWith(categories: resp));
    } catch (e) {
      emit(state.copyWith(error: true));
      print(e);
    }
  }
}
