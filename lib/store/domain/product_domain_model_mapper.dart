import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:storelist/store/domain/product_domain_model.dart';

abstract class Function1<T1, R> {
  // Abstract method: Subclasses must implement this.
  R execute(T1 arg1);
}

class ProductDomainModelMapper
    implements Function1<Response, ProductDomainModelList> {
  @override
  ProductDomainModelList execute(Response response) {
    try {
      List<dynamic> data = response.data ;
      var posts = data
          .map(
            (jsonItem) =>
                ProductDomainModel.fromJson(jsonItem),
          )
          .toList();
      return ProductDomainModelList(productDomainModels: posts);
    } catch (e) {
      throw Exception(" Failed to map response to ProductDomainModel: $e");
    }
  }
}
