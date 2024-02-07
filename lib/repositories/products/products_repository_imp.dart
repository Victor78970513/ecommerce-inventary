import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
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

  @override
  Future<bool> createNewProduct(Product newProduct) async {
    CollectionReference collectionCreateProductReference =
        db.collection("products");
    try {
      await collectionCreateProductReference.add(newProduct.productToJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<String> sendImageToFirebaseStorage(XFile imagePath) async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child("products");
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
    // await referenceImageToUpload.putFile(File(returnedImage.path));
    await referenceImageToUpload.putFile(File(imagePath.path));
    final imageUrl = await referenceImageToUpload.getDownloadURL();
    return imageUrl;
  }
}
