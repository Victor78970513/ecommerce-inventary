import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:yosyelan_inventary/models/poduct_model.dart';
import 'package:yosyelan_inventary/repositories/products/products_repository.dart';
import 'package:yosyelan_inventary/repositories/products/products_repository_imp.dart';

part 'create_product_event.dart';
part 'create_product_state.dart';

class CreateProductBloc extends Bloc<CreateProductEvent, CreateProductState> {
  late ProductsRepository _newProductRepository;

  CreateProductBloc() : super(CreateProductState()) {
    //
    _newProductRepository = ProductsRepositoryImp();
    //
    on<OnChangeProductValuesEvent>(_onChangeProductValuesEvent);
    on<OnSubmitNewProductFirebaseEvent>(_onSubmitNewProductFirebaseEvent);
  }

  FutureOr<void> _onChangeProductValuesEvent(
      OnChangeProductValuesEvent event, Emitter<CreateProductState> emit) {
    emit(state.copyWith(
      productName: event.productName,
      productDescription: event.productDescription,
      productPrice: event.productPrice,
      productStock: event.productStock,
      productImage: event.productImage,
    ));
    print(state.productName);
  }

  FutureOr<void> _onSubmitNewProductFirebaseEvent(
      OnSubmitNewProductFirebaseEvent event,
      Emitter<CreateProductState> emit) async {
    try {
      final resp =
          await _newProductRepository.createNewProduct(event.newProduct);
      emit(state.copyWith(productCreateError: !resp));
    } catch (e) {
      emit(state.copyWith(productCreateError: true));
    }
  }
}
