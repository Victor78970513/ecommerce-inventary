import 'package:yosyelan_inventary/models/category_model.dart';

abstract class CategoriesRepository {
  Future<List<Category>> getAllCategories();
}
