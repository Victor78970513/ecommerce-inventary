import 'package:flutter/material.dart';
import 'package:yosyelan_inventary/presentation/createProduct/screens/create_product_screen.dart';

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              "Elige una opcion",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text("Crear un Producto"),
              leading: const Icon(Icons.production_quantity_limits),
              subtitle:
                  const Text("Esta seccion es para crear un producto nuevo"),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateProductScreen())),
            ),
            ListTile(
              title: const Text("Crear una Categoria"),
              leading: const Icon(Icons.category),
              subtitle: const Text(
                  "Esta seccion es para crear una nueva categoria de productos"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
