import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomNavigationBar extends StatelessWidget {
  final ValueChanged<int> onIndexSelected;
  const CustomNavigationBar({super.key, required this.onIndexSelected});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const color = Colors.white;
    const iconSize = 30.0;
    return Container(
      height: size.height * 0.08,
      width: size.width,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () => onIndexSelected(0),
            icon: const Icon(
              Icons.home_filled,
              size: iconSize,
              color: color,
            ),
          ),
          IconButton(
            onPressed: () => onIndexSelected(1),
            icon: const Icon(
              Icons.search_outlined,
              color: color,
              size: iconSize,
            ),
          ),
          IconButton(
            onPressed: () => onIndexSelected(2),
            icon: const FaIcon(
              FontAwesomeIcons.shop,
              color: color,
              size: iconSize,
            ),
          ),
          IconButton(
            onPressed: () => onIndexSelected(3),
            icon: const FaIcon(
              FontAwesomeIcons.clipboardList,
              color: color,
              size: iconSize,
            ),
          )
        ],
      ),
    );
  }
}
