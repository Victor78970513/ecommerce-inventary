import 'package:cloud_firestore/cloud_firestore.dart';

// class Product {
//   final String name;
//   final String description;
//   final int price;
//   final int stock;
//   final String image;

//   Product({
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.stock,
//     required this.image,
//   });

//   factory Product.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
//     final json = documentSnapshot.data() as Map<String, dynamic>;

//     return Product(
//         name: json["name"],
//         description: json["description"],
//         price: json["price"],
//         stock: json["stock"],
//         image: json["image"]);
//   }

//   Map<String, dynamic> productToJson() {
//     return {
//       "name": name,
//       "description": description,
//       "price": price,
//       "stock": stock,
//       "image": image,
//     };
//   }
// }

class Product {
  final String name;
  final int cateogryid;

  Product({required this.name, required this.cateogryid});

  factory Product.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    final json = documentSnapshot.data() as Map<String, dynamic>;

    return Product(name: json["name"], cateogryid: json["category"]);
  }

  // Map<String, dynamic> productToJson() {
  //   return {
  //     "name": name,
  //     "description": description,
  //     "price": price,
  //     "stock": stock,
  //     "image": image,
  //   };
  // }
}
