
import 'package:fpdart/fpdart.dart';
import 'package:dio/dio.dart';
import 'package:storelist/store/failure.dart';
import '../domain/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
   final Dio dio;
  ProductRepositoryImpl(this.dio);

  @override
  Future<Either<Failure, Response>> fetchProductsData() async{  
    
    try {
      final response = await dio.get("https://fakestoreapi.com/products");
      return Right(response);
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  } 

}