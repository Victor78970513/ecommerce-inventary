import 'package:yosyelan_inventary/domain/entities/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> getAllProducts();

  Future<List<Product>> getProductsByCategory(String category);
}
