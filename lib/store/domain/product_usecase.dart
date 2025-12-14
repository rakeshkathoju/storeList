import 'package:fpdart/fpdart.dart';
import 'package:storelist/store/domain/product_domain_model.dart';
import 'package:storelist/store/domain/product_domain_model_mapper.dart';
import 'package:storelist/store/failure.dart';

import 'product_repository.dart';

class GetProductUseCase {
  final ProductRepository repository;
  final ProductDomainModelMapper _mapper;

  GetProductUseCase(this.repository, this._mapper);

  Future<Either<Failure, ProductDomainModelList>> fetchProductsData() async {
    final response = await repository.fetchProductsData();
    return  response.fold(
        (failure) =>  Left(failure),
        (response) {
          try {
            final productDomainModelList = _mapper.execute(response);
            return Right(productDomainModelList);
          } catch (e) {
            return Left(Failure(errorMessage: "Mapping Error: $e"));
          }
        },
      );
  }
}