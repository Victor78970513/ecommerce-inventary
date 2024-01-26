import 'package:flutter/material.dart';
import 'package:yosyelan_inventary/presentation/home/widgets/custom_navigationbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (page) {},
              controller: _pageController,
              children: const [
                Text("hola"),
                Text("hola2"),
                Text("hola3"),
              ],
            ),
          ),
          CustomNavigationBar(
            onIndexSelected: (int value) {},
          ),
        ],
      ),
    );
  }
}
