part of 'create_product_bloc.dart';

@immutable
sealed class CreateProductEvent {}

class OnChangeProductValuesEvent extends CreateProductEvent {
  final String? productName;
  final String? productDescription;
  final String? productImage;
  final int? productPrice;
  final int? productStock;
  final File? localImage;

  OnChangeProductValuesEvent({
    this.productName,
    this.productDescription,
    this.productImage,
    this.productPrice,
    this.productStock,
    this.localImage,
  });
}

class OnSubmitImageToStorage extends CreateProductEvent {
  final XFile imagePath;

  OnSubmitImageToStorage({required this.imagePath});
}

class OnSubmitNewProductFirebaseEvent extends CreateProductEvent {
  final Product newProduct;

  OnSubmitNewProductFirebaseEvent({required this.newProduct});
}
