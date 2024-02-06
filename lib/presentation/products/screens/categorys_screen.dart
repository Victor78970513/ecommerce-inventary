import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosyelan_inventary/presentation/products/bloc/categories/category_bloc.dart';
import 'package:yosyelan_inventary/presentation/products/widgets/categories_board.dart';

class CategorysScreen extends StatefulWidget {
  const CategorysScreen({super.key});

  @override
  State<CategorysScreen> createState() => _CategorysScreenState();
}

class _CategorysScreenState extends State<CategorysScreen> {
  @override
  void initState() {
    context.read<CategoryBloc>().add(OnGetCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: LayoutBuilder(builder: (context, constrains) {
        print(constrains.maxHeight);
        print(constrains.maxWidth);
        return SafeArea(
          child: Center(
              child: Column(
            children: [
              const Center(
                  child: Text("CATEGORIAS", style: TextStyle(fontSize: 25))),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[400],
                    ),
                    child: const Icon(Icons.search_outlined, size: 30),
                  ),
                  Container(
                    height: 50,
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        "Ver todos",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60, width: 60)
                ],
              ),
              const SizedBox(height: 15),
              const Expanded(child: CategoriesBoardWidget())
            ],
          )),
        );
      }),
    );
  }
}
