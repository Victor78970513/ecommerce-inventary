import 'package:flutter/material.dart';

class ProductsListScreen extends StatelessWidget {
  final int categoryId;
  const ProductsListScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Che estamos en la categoria $categoryId xd'),
      ),
    );
  }
}
