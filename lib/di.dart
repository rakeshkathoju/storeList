import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:storelist/store/data/product_repository_impl.dart';
import 'package:storelist/store/domain/product_domain_model_mapper.dart';
import 'package:storelist/store/domain/product_usecase.dart';
import 'package:storelist/store/presentation/product_bloc.dart';
import 'store/domain/product_repository.dart';

final getIt = GetIt.instance;



Future<void> init() async {
  // Register Dio as a singleton
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.options.baseUrl = "https://fakestoreapi.com/products";//"https://api.jyotishamastroapi.com/api";
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);

    // Optional: Add interceptors for logging, headers, etc.
    dio.interceptors.add(LogInterceptor(responseBody: true));
    return dio;
  });

  // Register your service, injecting Dio
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<GetProductUseCase>(
    () => GetProductUseCase(getIt(),getIt()),
  );
   getIt.registerLazySingleton<ProductBloc>(
    () => ProductBloc(getIt()),
  );
  getIt.registerLazySingleton<ProductDomainModelMapper>(
    () => ProductDomainModelMapper(),
  );
}

