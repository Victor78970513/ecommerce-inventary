import 'package:flutter/material.dart';
import 'package:yosyelan_inventary/presentation/createProduct/widgets/custom_text_form_field.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height * 0.4,
                width: size.width,
                child: Placeholder(),
              ),
              CustomInputTextFormField(),
            ],
          ),
        ),
      ),
    );
  }
}
