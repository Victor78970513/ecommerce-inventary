import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yosyelan_inventary/presentation/createProduct/bloc/create_product_bloc.dart';

import 'package:yosyelan_inventary/presentation/createProduct/widgets/custom_text_form_field.dart';

class CreateProductScreen extends StatefulWidget {
  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final TextEditingController nameCtrl = TextEditingController();

  final TextEditingController descriptionCtrl = TextEditingController();

  final TextEditingController priceCtrl = TextEditingController();

  final TextEditingController stockCtrl = TextEditingController();

  File? _selectedImage;

  @override
  void initState() {
    final bloc = context.read<CreateProductBloc>().state;
    nameCtrl.text = bloc.productName;
    super.initState();
  }

  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 100);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final createProductBloc = context.watch<CreateProductBloc>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height * 0.35,
                width: size.width * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: _selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.file(
                          _selectedImage!,
                          fit: BoxFit.fill,
                        ),
                      )
                    : const Placeholder(),
              ),
              const SizedBox(height: 20),
              CustomInputTextFormField(
                textController: nameCtrl,
                hintText: "nombre",
                labelText: "nombre",
                onChanged: (value) {
                  context.read<CreateProductBloc>().add(
                      OnChangeProductValuesEvent(productName: nameCtrl.text));
                },
              ),
              CustomInputTextFormField(
                textController: descriptionCtrl,
                hintText: "descripcion",
                labelText: "descripcion",
                onChanged: (value) {},
              ),
              CustomInputTextFormField(
                textController: priceCtrl,
                hintText: "precio",
                labelText: "precio",
                keyboardType: TextInputType.number,
                onChanged: (value) {},
              ),
              CustomInputTextFormField(
                textController: stockCtrl,
                hintText: "stock en deposito",
                labelText: "stock en deposito",
                keyboardType: TextInputType.number,
                onChanged: (value) {},
              ),
              ElevatedButton(
                  onPressed: () {
                    print(context.read<CreateProductBloc>().state.productName);
                  },
                  child: Text("orueb")),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () => _pickImageFromGallery(),
              icon: const Icon(Icons.camera_alt_rounded, size: 60)),
          SizedBox(height: size.height * 0.05)
        ],
      ),
    );
  }
}
