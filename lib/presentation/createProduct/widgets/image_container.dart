import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yosyelan_inventary/presentation/createProduct/bloc/create_product/create_product_bloc.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key});

  Future<void> _pickImageFromGallery(BuildContext context) async {
    final returnedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 100);
    if (returnedImage == null) return;
    if (!context.mounted) return;
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
