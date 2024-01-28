part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}

class OnGetAllProductsEvent extends ProductsEvent {}

class OnGetProductsByCategoryEvent extends ProductsEvent {
  final int categoryId;

  OnGetProductsByCategoryEvent({required this.categoryId});
}
