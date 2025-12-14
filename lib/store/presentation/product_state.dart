import '../domain/product_domain_model.dart';

abstract class ProductState {}


class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final ProductDomainModelList data;
  ProductLoaded(this.data);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}