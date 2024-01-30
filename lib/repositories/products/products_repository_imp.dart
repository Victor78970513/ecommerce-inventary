import 'package:yosyelan_inventary/models/poduct_model.dart';
import 'package:yosyelan_inventary/repositories/products/products_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsRepositoryImp extends ProductsRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<List<Product>> getAllProducts() async {
    List<Product> products = [];
    CollectionReference collectionProductsReference = db.collection("products");
    QuerySnapshot queryProducts = await collectionProductsReference.get();
    queryProducts.docs.forEach(
        (product) => products.add(Product.fromDocumentSnapshot(product)));
    return products;
  }

  @override
  Future<List<Product>> getProductsByCategory(int categoryId) async {
    List<Product> categoryProducts = [];
    CollectionReference collectionProductsByCategoryReference =
        db.collection("products");
    QuerySnapshot queryCategoryProducts =
        await collectionProductsByCategoryReference
            .where('category', isEqualTo: categoryId)
            .get();

    queryCategoryProducts.docs.forEach((product) =>
        categoryProducts.add(Product.fromDocumentSnapshot(product)));
    return categoryProducts;
  }
}
