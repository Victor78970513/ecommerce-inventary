import 'package:yosyelan_inventary/domain/datasource/products_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yosyelan_inventary/domain/entities/product.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class ProductsDBDatasource extends ProductsDatasource {
  @override
  Future<List<Product>> getAllProducts() async {
    List<Product> products = [];
    CollectionReference collectionRefrenceProducts = db.collection("products");
    QuerySnapshot queryProduct = await collectionRefrenceProducts.get();
    queryProduct.docs.forEach((product) {
      products.add(product.data() as Product);
    });

    return products;
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    List<Product> products = [];
    CollectionReference collectionRefrenceProductsCetegory =
        db.collection("products");

    QuerySnapshot queryProduct = await collectionRefrenceProductsCetegory.get();
    queryProduct.docs.forEach((product) {
      products.add(product.data() as Product);
    });

    return products;
  }
}
