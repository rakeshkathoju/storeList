import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:storelist/store/failure.dart';

abstract class ProductRepository {
  Future<Either<Failure, Response>> fetchProductsData(); 
}