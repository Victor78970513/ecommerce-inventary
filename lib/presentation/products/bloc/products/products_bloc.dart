import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:yosyelan_inventary/models/poduct_model.dart';
import 'package:yosyelan_inventary/repositories/products/products_repository.dart';
import 'package:yosyelan_inventary/repositories/products/products_repository_imp.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  late ProductsRepository _allProductsRepository;
  late ProductsRepository _productsByCategoryRepository;

  ProductsBloc() : super(ProductsState()) {
    //
    _allProductsRepository = ProductsRepositoryImp();
    _productsByCategoryRepository = ProductsRepositoryImp();
    //
    on<OnGetAllProductsEvent>(onGetAllProductsEvent);
    on<OnGetProductsByCategoryEvent>(onGetProductsByCategoryEvent);
  }

  FutureOr<void> onGetAllProductsEvent(
      OnGetAllProductsEvent event, Emitter<ProductsState> emit) async {
    try {
      emit(state.copyWith(loadingAllProducts: true));
      final resp = await _allProductsRepository.getAllProducts();
      emit(state.copyWith(allProductsList: resp, loadingAllProducts: false));
    } catch (e) {
      emit(state.copyWith(allProductsError: true));
      print("error");
      print(e);
    }
  }

  FutureOr<void> onGetProductsByCategoryEvent(
      OnGetProductsByCategoryEvent event, Emitter<ProductsState> emit) async {
    try {
      emit(state.copyWith(loadingProductsByCategory: true));
      final resp = await _productsByCategoryRepository
          .getProductsByCategory(event.categoryId);

      emit(state.copyWith(
          prodcutsByCategoryList: resp, loadingProductsByCategory: false));
    } catch (e) {
      emit(state.copyWith(productsByCategoryError: true));
      print("error");
    }
  }
}
