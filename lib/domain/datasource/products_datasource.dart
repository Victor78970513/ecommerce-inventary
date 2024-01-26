import 'package:yosyelan_inventary/domain/entities/product.dart';

abstract class ProductsDatasource {
  Future<List<Product>> getAllProducts();

  Future<List<Product>> getProductsByCategory(String category);
}
