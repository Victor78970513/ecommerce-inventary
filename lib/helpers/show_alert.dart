import 'package:flutter/material.dart';

showProgressProduct(BuildContext context) {
  return showDialog(
      context: context,
      builder: (_) {
        return const PopScope(
          canPop: false,
          child: AlertDialog(
            content: SizedBox(
              height: 100,
              width: 200,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      });
}

customSnackBar(BuildContext context) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text("cheeeeeeeeeeeee")));
  // return const SnackBar(content: Text("CHE OCURRIO UN PROBLEMA"));
}
