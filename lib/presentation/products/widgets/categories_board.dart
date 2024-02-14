import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosyelan_inventary/models/category_model.dart';
import 'package:yosyelan_inventary/presentation/products/bloc/categories/category_bloc.dart';
import 'package:yosyelan_inventary/presentation/products/bloc/products/products_bloc.dart';
import 'package:yosyelan_inventary/presentation/products/screens/products_list_screen.dart';
import 'package:yosyelan_inventary/theme/colors_theme.dart';

class CategoriesBoardWidget extends StatelessWidget {
  const CategoriesBoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final categoriesBloc = context.watch<CategoryBloc>();
    final categoriesList = categoriesBloc.state.categories;
    final getHalfList = categoriesList.length ~/ 2;
    return SingleChildScrollView(
      child: Column(
        children: [
          categoriesList.isNotEmpty
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //TODO: USE CATEGORIES FROM BACKEND
                    CustomCategoryColumnCard(
                      isleft: true,
                      itemCount: categoriesList.length.isEven
                          ? getHalfList
                          : getHalfList + 1,
                      categories: categoriesList.sublist(
                        0,
                        categoriesList.length.isEven
                            ? getHalfList
                            : getHalfList + 1,
                      ),
                    ),
                    CustomCategoryColumnCard(
                      isleft: false,
                      itemCount: getHalfList,
                      categories: categoriesList.sublist(
                        categoriesList.length.isEven
                            ? getHalfList
                            : getHalfList + 1,
                        categoriesList.length,
                      ),
                    ),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
          SizedBox(height: size.height * 0.1)
        ],
      ),
    );
  }
}

class CustomCategoryColumnCard extends StatelessWidget {
  final bool isleft;
  final int itemCount;
  final List<Category> categories;

  const CustomCategoryColumnCard({
    super.key,
    required this.isleft,
    required this.itemCount,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    late int indexColor;
    isleft ? indexColor = -1 : indexColor = 3;
    return Column(
        children: List.generate(
      itemCount,
      (index) {
        if (isleft) {
          indexColor++;
          if (indexColor > 2) {
            indexColor = 0;
          }
        } else {
          indexColor--;
          if (indexColor < 0) {
            indexColor = 3;
          }
        }
        return GestureDetector(
          onTap: () {
            context.read<ProductsBloc>().add(
                OnGetProductsByCategoryEvent(categoryId: categories[index].id));

            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProductsListScreen()));
          },
          child: Container(
            height: isleft
                ? index.isEven
                    // ? 90
                    ? size.height * 0.1
                    // : 220
                    : size.height * 0.23
                : index.isEven
                    // ? 220
                    ? size.height * 0.23
                    // : 90,
                    : size.height * 0.1,
            width: size.width * 0.47,
            margin: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              // color: Colors.green,
              color: Colors.white,
              border: Border.all(
                width: 4,
                color: ColorsAppTheme.appColors[indexColor],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isleft ? 45 : 0),
                topRight: Radius.circular(isleft ? 0 : 45),
                bottomLeft: const Radius.circular(45),
                bottomRight: const Radius.circular(45),
              ),
            ),
            child: Center(
              child: Text(
                "${categories[index].id} ${categories[index].name}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    ));
  }
}
