import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final int id;
  final String name;
  final String image;

  Category({
    required this.name,
    required this.image,
    required this.id,
  });

  factory Category.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    final json = documentSnapshot.data() as Map<String, dynamic>;
    return Category(name: json["name"], image: json["img"], id: json["id"]);
  }

  Map<String, dynamic> categoryToJson() {
    return {
      "id": id,
      "name": name,
      "img": image,
    };
  }
}
