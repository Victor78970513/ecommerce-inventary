import 'package:yosyelan_inventary/models/poduct_model.dart';

abstract class ProductsRepository {
  Future<List<Product>> getAllProducts();

  Future<List<Product>> getProductsByCategory();
}
