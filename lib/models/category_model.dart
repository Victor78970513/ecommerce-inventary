import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String name;
  final String image;

  Category({required this.name, required this.image});

  factory Category.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    final json = documentSnapshot.data() as Map<String, dynamic>;
    return Category(name: json["name"], image: json["img"]);
  }

  Map<String, dynamic> categoryToJson() {
    return {
      "name": name,
      "img": image,
    };
  }
}
