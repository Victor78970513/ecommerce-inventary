import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosyelan_inventary/presentation/home/bloc/home_bloc_bloc.dart';
import 'package:yosyelan_inventary/presentation/home/widgets/custom_navigationbar.dart';
import 'package:yosyelan_inventary/presentation/products/screens/categorys_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.watch<HomeBloc>();
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (page) {
              print("estamos en $page");
              homeBloc.add(HomeChangeScreenEvent(index: page));
            },
            controller: _pageController,
            children: const [
              CategorysScreen(),
              Center(child: Text("hola2")),
              Center(child: Text("hola3")),
              Center(child: Text("hola4")),
            ],
          ),
          Positioned(
            bottom: 0,
            child: CustomNavigationBar(
              onIndexSelected: (int value) {
                homeBloc.add(HomeChangeScreenEvent(index: value));
                _pageController.animateToPage(
                  value,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
