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

  @override
  void initState() {
    final bloc = context.read<CreateProductBloc>().state;
    nameCtrl.text = bloc.productName;
    descriptionCtrl.text = bloc.productDescription;
    priceCtrl.text = bloc.productPrice.toString();
    stockCtrl.text = bloc.productStock.toString();
    super.initState();
  }

  // Future<void> _pickImageFromGallery() async {
  //   final returnedImage = await ImagePicker()
  //       .pickImage(source: ImageSource.camera, imageQuality: 100);
  //   if (returnedImage == null) return;
  //   final createProductBloc = context.read<CreateProductBloc>();
  //   createProductBloc
  //       .add(OnChangeProductValuesEvent(localImage: File(returnedImage.path)));
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final createProductBloc = context.watch<CreateProductBloc>();
    // final localImage = createProductBloc.state.localImage;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _ImageContainer(
                  // child: [
                  //   ClipRRect(
                  //     borderRadius: BorderRadius.circular(40),
                  //     child: localImage != null
                  //         ? Image.file(
                  //             // _selectedImage!,
                  //             localImage,
                  //             frameBuilder: (BuildContext context, Widget child,
                  //                 int? frame, bool wasSynchronouslyLoaded) {
                  //               if (wasSynchronouslyLoaded) {
                  //                 return const Center(
                  //                     child: CircularProgressIndicator());
                  //               }
                  //               return child;
                  //             },
                  //             fit: BoxFit.fill,
                  //           )
                  //         : Image.asset("assets/no-image.jpg"),
                  //   ),
                  // ],
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
              onPressed: () {},
              // onPressed: () => _pickImageFromGallery(),
              icon: const Icon(Icons.camera_alt_rounded, size: 60)),
          SizedBox(height: size.height * 0.05)
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
      ),
      child: Stack(children: [
        Expanded(
          child: Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: localImage != null
                  ? Image.file(
                      // _selectedImage!,
                      localImage,
                      frameBuilder: (BuildContext context, Widget child,
                          int? frame, bool wasSynchronouslyLoaded) {
                        if (wasSynchronouslyLoaded) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return child;
                      },
                      fit: BoxFit.fill,
                    )
                  : Image.asset("assets/no-image.jpg"),
            ),
          ),
        ),
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
      ]),
    );
  }
}
