import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:yosyelan_inventary/models/poduct_model.dart';
import 'package:yosyelan_inventary/presentation/home/bloc/home_bloc_bloc.dart';
import 'package:yosyelan_inventary/repositories/products/products_repository.dart';
import 'package:yosyelan_inventary/repositories/products/products_repository_imp.dart';

part 'create_product_event.dart';
part 'create_product_state.dart';

class CreateProductBloc extends Bloc<CreateProductEvent, CreateProductState> {
  late ProductsRepository _newProductRepository;
  final HomeBloc homeBloc;

  CreateProductBloc({
    required this.homeBloc,
  }) : super(CreateProductState()) {
    //
    _newProductRepository = ProductsRepositoryImp();
    //
    on<OnChangeProductValuesEvent>(_onChangeProductValuesEvent);
    on<OnSubmitImageToStorage>(_onSubmitImageToStorage);
    on<OnSubmitNewProductFirebaseEvent>(_onSubmitNewProductFirebaseEvent);
    on<OnClearValuesEvent>(_onClearValuesEvent);
  }

  FutureOr<void> _onChangeProductValuesEvent(
      OnChangeProductValuesEvent event, Emitter<CreateProductState> emit) {
    emit(state.copyWith(
      productName: event.productName,
      productDescription: event.productDescription,
      productPrice: event.productPrice,
      productStock: event.productStock,
      productImage: event.productImage,
      localImage: event.localImage,
    ));
  }

  FutureOr<void> _onSubmitNewProductFirebaseEvent(
      OnSubmitNewProductFirebaseEvent event,
      Emitter<CreateProductState> emit) async {
    try {
      final resp =
          await _newProductRepository.createNewProduct(event.newProduct);
      print("recien hare el emit");
      emit(state.copyWith(productCreateError: !resp, sendSuccess: true));
      print("SUCCESS ${state.sendSuccess}");
      add(OnClearValuesEvent());
      homeBloc.add(HomeChangeScreenEvent(index: 0));
    } catch (e) {
      print(e);
      emit(state.copyWith(productCreateError: true));
    }
  }

  FutureOr<void> _onSubmitImageToStorage(
      OnSubmitImageToStorage event, Emitter<CreateProductState> emit) async {
    final imageUrl =
        await _newProductRepository.sendImageToFirebaseStorage(event.imagePath);
    emit(state.copyWith(productImage: imageUrl));
    print("imagenURL: $imageUrl");
  }

  FutureOr<void> _onClearValuesEvent(
      OnClearValuesEvent event, Emitter<CreateProductState> emit) {
    emit(state.copyWith(
      productName: "",
      productDescription: "",
      productImage: "",
      localImage: null,
      productPrice: 0,
      productStock: 0,
      sendSuccess: false,
    ));
  }
}
