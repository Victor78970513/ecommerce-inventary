import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosyelan_inventary/presentation/searchProduct/bloc/search_bloc.dart';

class SearchDelegateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchBloc = context.watch<SearchBloc>();
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: size.width * 0.8,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: TextField(
            onChanged: (value) {
              searchBloc.add(OnChangeSearchNameEvent(newSearch: value));
            },
            style: const TextStyle(fontSize: 20),
            autofocus: false,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Buscar",
              contentPadding: EdgeInsets.only(left: size.width * 0.1, top: 5),
              suffixIcon: const Icon(Icons.search_outlined),
            ),
          ),
        ),
      ),
    );
  }
}
