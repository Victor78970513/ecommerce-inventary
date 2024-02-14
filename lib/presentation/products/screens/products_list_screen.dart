import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosyelan_inventary/presentation/products/bloc/products/products_bloc.dart';
import 'package:yosyelan_inventary/presentation/products/widgets/product_card.dart';

class ProductsListScreen extends StatelessWidget {
  const ProductsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsBloc = context.watch<ProductsBloc>();
    final size = MediaQuery.sizeOf(context);

    return productsBloc.state.loadingProductsByCategory == true
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: GridView.builder(
                itemCount: productsBloc.state.prodcutsByCategoryList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: size.height * 0.3,
                ),
                itemBuilder: (context, index) {
                  final product =
                      productsBloc.state.prodcutsByCategoryList[index];
                  return ProductCard(product: product);
                },
              ),
            ),
          );
  }
}
