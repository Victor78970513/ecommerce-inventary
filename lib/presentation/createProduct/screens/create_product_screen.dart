import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yosyelan_inventary/helpers/show_alert.dart';
import 'package:yosyelan_inventary/models/poduct_model.dart';
import 'package:yosyelan_inventary/presentation/createProduct/bloc/create_product/create_product_bloc.dart';

import 'package:yosyelan_inventary/presentation/createProduct/widgets/custom_text_form_field.dart';
import 'package:yosyelan_inventary/presentation/createProduct/widgets/image_container.dart';
import 'package:yosyelan_inventary/repositories/products/products_repository_imp.dart';

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

  Future<void> sendProduct(BuildContext context) async {
    final createProductBloc = context.read<CreateProductBloc>().state;
    final imageUrl = await ProductsRepositoryImp()
        .sendImageToFirebaseStorage(XFile(createProductBloc.localImage!.path));
    if (imageUrl != "" && context.mounted) {
      context.read<CreateProductBloc>().add(OnSubmitNewProductFirebaseEvent(
              newProduct: Product(
            name: createProductBloc.productName,
            categoryId: 1,
            description: createProductBloc.productDescription,
            price: createProductBloc.productPrice,
            stock: createProductBloc.productStock,
            image: imageUrl,
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductBloc, CreateProductState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ImageContainer(),
                  const SizedBox(height: 20),
                  CustomInputTextFormField(
                    textController: nameCtrl,
                    hintText: "nombre",
                    labelText: "nombre",
                    onChanged: (value) {
                      context.read<CreateProductBloc>().add(
                          OnChangeProductValuesEvent(
                              productName: nameCtrl.text));
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
          floatingActionButton: IconButton(
              onPressed: () async {
                showProgressProduct(context);
                await sendProduct(context);
                if (!state.loading && context.mounted) {
                  Navigator.of(context)
                    ..pop()
                    ..pop();
                } else if (!state.loading &&
                    state.productCreateError &&
                    context.mounted) {
                  Navigator.of(context).pop();
                  customSnackBar(context);
                }
              },
              icon: const Icon(Icons.save_as_rounded, size: 60)),
        );
      },
    );
  }
}
