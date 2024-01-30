import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosyelan_inventary/models/poduct_model.dart';
import 'package:yosyelan_inventary/presentation/searchProduct/bloc/search_bloc.dart';
import 'package:yosyelan_inventary/presentation/searchProduct/widget/search_delegate.dart';

class SearchProductScreen extends StatelessWidget {
  const SearchProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchBloc = context.watch<SearchBloc>().state;
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          children: [
            SearchDelegateWidget(),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("products")
                  .orderBy("name")
                  .startAt([searchBloc.searchName]).endAt(
                      ["${searchBloc.searchName}\uf8ff"]).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text("Something went wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("loading");
                }
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      final data = Product.fromDocumentSnapshot(
                          snapshot.data!.docs[index]);
                      return ListTile(
                        title: Text(data.name),
                      );
                    });
              },
            )),
            const SizedBox(height: 100)
          ],
        ),
      ),
    ));
  }
}
