import 'package:flutter/material.dart';

const i = 11;
const List<String> names = [
  "a",
  "b",
  "c",
  "d",
  "e",
  "f",
  "g",
  "h",
  "i",
  "j",
  "k"
];

class CategoriesBoardWidget extends StatelessWidget {
  const CategoriesBoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //TODO: USE CATEGORIES FROM BACKEND
              CustomCategoryColumnCard(
                isleft: true,
                itemCount: i ~/ 2 + 1,
                categories: names.sublist(0, (i ~/ 2 + 1)),
              ),
              CustomCategoryColumnCard(
                isleft: false,
                itemCount: i ~/ 2,
                categories: names.sublist((i ~/ 2 + 1), names.length),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.1,
          )
        ],
      ),
    );
  }
}

class CustomCategoryColumnCard extends StatelessWidget {
  final bool isleft;
  final int itemCount;
  final List<String> categories;

  const CustomCategoryColumnCard({
    super.key,
    required this.isleft,
    required this.itemCount,
    required this.categories,
  });
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
        children: List.generate(
      itemCount,
      (index) {
        return Container(
          height: isleft
              ? index.isEven
                  ? 90
                  : 220
              : index.isEven
                  ? 220
                  : 90,
          width: size.width * 0.48,
          margin: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isleft ? 45 : 0),
              topRight: Radius.circular(isleft ? 0 : 45),
              bottomLeft: const Radius.circular(45),
              bottomRight: const Radius.circular(45),
            ),
          ),
          child: Center(child: Text(categories[index])),
        );
      },
    ));
  }
}
