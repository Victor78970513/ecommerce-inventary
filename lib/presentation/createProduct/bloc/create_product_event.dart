part of 'create_product_bloc.dart';

@immutable
sealed class CreateProductEvent {}

class OnChangeProductValuesEvent extends CreateProductEvent {
  final String? productName;
  final String? productDescription;
  final String? productImage;
  final int? productPrice;
  final int? productStock;

  OnChangeProductValuesEvent({
    this.productName,
    this.productDescription,
    this.productImage,
    this.productPrice,
    this.productStock,
  });
}

class OnSubmitNewProductFirebaseEvent extends CreateProductEvent {
  final Product newProduct;

  OnSubmitNewProductFirebaseEvent({required this.newProduct});
}
