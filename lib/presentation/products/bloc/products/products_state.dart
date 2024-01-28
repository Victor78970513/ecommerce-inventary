part of 'products_bloc.dart';

class ProductsState {
  final List<Product> allProductsList;
  final List<Product> prodcutsByCategoryList;

  final bool loadingAllProducts;
  final bool loadingProductsByCategory;

  final bool allProductsError;
  final bool productsByCategoryError;

  ProductsState({
    this.allProductsList = const [],
    this.prodcutsByCategoryList = const [],
    this.loadingAllProducts = true,
    this.loadingProductsByCategory = true,
    this.allProductsError = false,
    this.productsByCategoryError = false,
  });

  ProductsState copyWith({
    List<Product>? allProductsList,
    List<Product>? prodcutsByCategoryList,
    bool? loadingAllProducts,
    bool? loadingProductsByCategory,
    bool? allProductsError,
    bool? productsByCategoryError,
  }) =>
      ProductsState(
        allProductsList: allProductsList ?? this.allProductsList,
        prodcutsByCategoryList:
            prodcutsByCategoryList ?? this.prodcutsByCategoryList,
        loadingAllProducts: loadingAllProducts ?? this.loadingAllProducts,
        loadingProductsByCategory:
            loadingProductsByCategory ?? this.loadingProductsByCategory,
        allProductsError: allProductsError ?? this.allProductsError,
        productsByCategoryError:
            productsByCategoryError ?? this.productsByCategoryError,
      );
}
