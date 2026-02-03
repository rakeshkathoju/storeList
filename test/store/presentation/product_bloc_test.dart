import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storelist/store/domain/product_domain_model.dart';
import 'package:storelist/store/domain/product_usecase.dart';
import 'product_state.dart';



class ProductBloc extends Cubit<ProductState> {
  final GetProductUseCase _getProductUseCase;

   ProductBloc(
     GetProductUseCase getProductUseCase,
  )  : _getProductUseCase = getProductUseCase, super(ProductLoading());


  Future<void> fetchProductsData( ) async {
      final data = await _getProductUseCase.fetchProductsData();
      data.fold(
        (failure) => emit(ProductError(failure.errorMessage)),
        (productDomainModelList) => emit(ProductLoaded(productDomainModelList)),
      );
  }
  
}


