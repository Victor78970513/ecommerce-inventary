import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yosyelan_inventary/models/poduct_model.dart';
import 'package:yosyelan_inventary/presentation/createProduct/bloc/create_product_bloc.dart';

import 'package:yosyelan_inventary/presentation/createProduct/widgets/custom_text_form_field.dart';
import 'package:yosyelan_inventary/repositories/products/products_repository_imp.dart';

XFile? xfile;

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final TextEditingController nameCtrl = TextEditingController();

  final TextEditingController descriptionCtrl = TextEditingController();

  final TextEditingController priceCtrl = TextEditingController();

  final TextEditingController stockCtrl = TextEditingController();

  @override
  void initState() {
    final bloc = context.read<CreateProductBloc>().state;
    nameCtrl.text = bloc.productName;
    descriptionCtrl.text = bloc.productDescription;
    priceCtrl.text = bloc.productPrice.toString();
    stockCtrl.text = bloc.productStock.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final createProductBloc = context.watch<CreateProductBloc>().state;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _ImageContainer(),
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
              onPressed: () async {
                final imageUrl = await ProductsRepositoryImp()
                    .sendImageToFirebaseStorage(xfile!);
                if (imageUrl != "") {
                  context
                      .read<CreateProductBloc>()
                      .add(OnSubmitNewProductFirebaseEvent(
                        newProduct: Product(
                          name: createProductBloc.productName,
                          categoryId: 101,
                          description: createProductBloc.productDescription,
                          price: createProductBloc.productPrice,
                          stock: createProductBloc.productStock,
                          image: imageUrl,
                        ),
                      ));
                }
                // });
              },
              icon: const Icon(Icons.save_as_rounded, size: 60)),
          SizedBox(height: size.height * 0.07)
        ],
      ),
    );
  }
}

class _ImageContainer extends StatelessWidget {
  Future<void> _pickImageFromGallery(BuildContext context) async {
    final returnedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 100);
    if (returnedImage == null) return;
    final createProductBloc = context.read<CreateProductBloc>();
    createProductBloc
        .add(OnChangeProductValuesEvent(localImage: File(returnedImage.path)));
    xfile = returnedImage;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final createProductBloc = context.watch<CreateProductBloc>();
    final localImage = createProductBloc.state.localImage;
    return Container(
      height: size.height * 0.3,
      width: size.width * 0.85,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          image: localImage != null
              ? DecorationImage(image: FileImage(localImage), fit: BoxFit.fill)
              : const DecorationImage(
                  image: AssetImage("assets/no-image.jpg"), fit: BoxFit.fill)),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
                onPressed: () => _pickImageFromGallery(context),
                icon: const Icon(
                  Icons.camera_alt_rounded,
                  size: 60,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }
}
