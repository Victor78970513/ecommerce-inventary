import 'package:yosyelan_inventary/domain/datasource/products_datasource.dart';
import 'package:yosyelan_inventary/domain/entities/product.dart';
import 'package:yosyelan_inventary/domain/repositories/products_repository.dart';

class ProductRepositoryImpl extends ProductsRepository {
  final ProductsDatasource datasource;

  ProductRepositoryImpl(this.datasource);

  @override
  Future<List<Product>> getAllProducts() {
    return datasource.getAllProducts();
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) {
    return datasource.getProductsByCategory(category);
  }
}
