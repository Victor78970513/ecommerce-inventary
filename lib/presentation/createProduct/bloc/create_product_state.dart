part of 'create_product_bloc.dart';

class CreateProductState {
  final bool productCreateError;
  final String productName;
  final String productDescription;
  final String productImage;
  final int productPrice;
  final int productStock;
  final File? localImage;

  CreateProductState({
    this.productCreateError = false,
    this.productName = "",
    this.productDescription = "",
    this.productImage = "",
    this.productPrice = 0,
    this.productStock = 0,
    this.localImage,
  });

  CreateProductState copyWith({
    bool? productCreateError,
    String? productName,
    String? productDescription,
    String? productImage,
    int? productPrice,
    int? productStock,
    File? localImage,
  }) =>
      CreateProductState(
        productCreateError: productCreateError ?? this.productCreateError,
        productName: productName ?? this.productName,
        productDescription: productDescription ?? this.productDescription,
        productImage: productImage ?? this.productImage,
        productPrice: productPrice ?? this.productPrice,
        productStock: productStock ?? this.productStock,
        localImage: localImage ?? this.localImage,
      );
}