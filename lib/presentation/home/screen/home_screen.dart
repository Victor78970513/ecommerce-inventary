import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosyelan_inventary/presentation/home/bloc/home_bloc_bloc.dart';
import 'package:yosyelan_inventary/presentation/home/widgets/custom_navigationbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.watch<HomeBloc>();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (page) {
                print("estamos en $page");
                homeBloc.add(HomeChangeScreenEvent(index: page));
              },
              controller: _pageController,
              children: const [
                Center(child: Text("hola")),
                Center(child: Text("hola2")),
                Center(child: Text("hola3")),
                Center(child: Text("hola4")),
              ],
            ),
          ),
          CustomNavigationBar(
            onIndexSelected: (int value) {
              homeBloc.add(HomeChangeScreenEvent(index: value));
              _pageController.animateToPage(value,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear);
            },
          ),
        ],
      ),
    );
  }
}
