import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:yosyelan_inventary/models/poduct_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: FadeIn(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                width: 2,
                color: Colors.black,
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: size.height * 0.15,
                    width: double.infinity,
                    child: Image.network(product.image, fit: BoxFit.fill),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 2,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(product.name),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("Compra: ${product.price} Bs"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("Venta: ${product.price} Bs"),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text("12 disp x 24 u."),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("${product.stock} cajas"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
