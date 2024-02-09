import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosyelan_inventary/firebase_options.dart';
import 'package:yosyelan_inventary/presentation/createProduct/bloc/create_product/create_product_bloc.dart';
import 'package:yosyelan_inventary/presentation/home/bloc/home_bloc_bloc.dart';
import 'package:yosyelan_inventary/presentation/home/screens/home_screen.dart';
import 'package:yosyelan_inventary/presentation/products/bloc/categories/category_bloc.dart';
import 'package:yosyelan_inventary/presentation/products/bloc/products/products_bloc.dart';
import 'package:yosyelan_inventary/presentation/searchProduct/bloc/search_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(create: (context) => ProductsBloc()),
        BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(
            create: (context) => CreateProductBloc(
                homeBloc: BlocProvider.of<HomeBloc>(context))),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: HomeScreen(),
      ),
    );
  }
}
