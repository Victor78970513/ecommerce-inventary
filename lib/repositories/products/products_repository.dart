import 'package:image_picker/image_picker.dart';
import 'package:yosyelan_inventary/models/poduct_model.dart';

abstract class ProductsRepository {
  Future<List<Product>> getAllProducts();

  Future<List<Product>> getProductsByCategory(int categoryId);

  Future<String> sendImageToFirebaseStorage(XFile imagePath);

  Future<bool> createNewProduct(Product newProduct);
}
