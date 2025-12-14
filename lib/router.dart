import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storelist/di.dart';
import 'package:storelist/product_details.dart';
import 'package:storelist/product_list.dart';
import 'package:storelist/store/domain/product_domain_model.dart';
import 'package:storelist/store/presentation/product_bloc.dart';

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => BlocProvider<ProductBloc>(
        // Wrap the screen here
        create: (context) => getIt<ProductBloc>(), // Create a new instance
        child: const ProductList(),
      ),
      routes: <RouteBase>[
        GoRoute(
          name: 'details',
          path: 'details',
          builder: (context, state) {
            final product = state.extra as ProductDomainModel;
            return ProductDetails(productDomainModel: product);
          },
        ),
      ],
    ),
  ],
);

GoRouter get router => _router;
