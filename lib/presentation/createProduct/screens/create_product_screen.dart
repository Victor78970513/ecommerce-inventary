import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
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
  String imageUrl = '';

  @override
  void initState() {
    final bloc = context.read<CreateProductBloc>().state;
    nameCtrl.text = bloc.productName;
    descriptionCtrl.text = bloc.productDescription;
    priceCtrl.text = bloc.productPrice.toString();
    stockCtrl.text = bloc.productStock.toString();
    super.initState();
  }

  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 100);
    if (returnedImage == null) return;

    _selectedImage = File(returnedImage.path);
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child("products");
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
    await referenceImageToUpload.putFile(File(returnedImage.path));
    imageUrl = await referenceImageToUpload.getDownloadURL();
    print(imageUrl);
    setState(() {});
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
                onChanged: (value) {
                  context.read<CreateProductBloc>().add(
                      OnChangeProductValuesEvent(productName: nameCtrl.text));
                },
              ),
              CustomInputTextFormField(
                textController: descriptionCtrl,
                hintText: "descripcion",
                labelText: "descripcion",
                onChanged: (value) {
                  context.read<CreateProductBloc>().add(
                      OnChangeProductValuesEvent(
                          productDescription: descriptionCtrl.text));
                },
              ),
              CustomInputTextFormField(
                textController: priceCtrl,
                hintText: "precio",
                labelText: "precio",
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  context.read<CreateProductBloc>().add(
                      OnChangeProductValuesEvent(
                          productPrice: int.parse(priceCtrl.text)));
                },
              ),
              CustomInputTextFormField(
                textController: stockCtrl,
                hintText: "stock en deposito",
                labelText: "stock en deposito",
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  context.read<CreateProductBloc>().add(
                      OnChangeProductValuesEvent(
                          productStock: int.parse(stockCtrl.text)));
                },
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
