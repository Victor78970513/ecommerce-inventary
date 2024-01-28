import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yosyelan_inventary/models/category_model.dart';
import 'package:yosyelan_inventary/repositories/categories/categories_repository.dart';

class CategoriesRepositoriesImp extends CategoriesRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Future<List<Category>> getAllCategories() async {
    List<Category> categories = [];
    CollectionReference collectionCategoriesReference =
        db.collection("category");

    QuerySnapshot queryCategories = await collectionCategoriesReference.get();
    queryCategories.docs.forEach(
        (category) => categories.add(Category.fromDocumentSnapshot(category)));
    return categories;
  }
}
