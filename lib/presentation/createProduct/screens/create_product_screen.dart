import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yosyelan_inventary/presentation/createProduct/widgets/custom_text_form_field.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  TextEditingController nameCtrl = TextEditingController();

  TextEditingController descriptionCtrl = TextEditingController();

  TextEditingController priceCtrl = TextEditingController();

  TextEditingController stockCtrl = TextEditingController();

  File? _selectedImage;

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
              ),
              CustomInputTextFormField(
                textController: descriptionCtrl,
                hintText: "descripcion",
                labelText: "descripcion",
              ),
              CustomInputTextFormField(
                textController: priceCtrl,
                hintText: "precio",
                labelText: "precio",
              ),
              CustomInputTextFormField(
                textController: stockCtrl,
                hintText: "stock en deposito",
                labelText: "stock en deposito",
              ),
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
