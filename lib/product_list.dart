import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storelist/store/domain/product_domain_model.dart';
import 'package:storelist/store/presentation/product_bloc.dart';
import 'package:storelist/store/presentation/product_state.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Product List'),
      ),
      body: BlocBuilder(
        bloc: context.read<ProductBloc>()..fetchProductsData(),
        builder: (context, state) {
          if (state is ProductLoading) {
            return CircularProgressIndicator();
          } else if (state is ProductLoaded) {
            return _buildProductList(context, state.data.productDomainModels);
          } else if (state is ProductError) {
            return Text('Error: ${state.message}');
          } else {
            return Text('Unknown state');
          }
        },
      ),
    );
  }

  Widget _buildProductList(
    BuildContext context,
    List<ProductDomainModel> productDomainModels,
  ) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        mainAxisSpacing: 8.0, 
        crossAxisSpacing: 8.0, 
      ),
      padding: EdgeInsets.all(8.0), 
      itemCount: productDomainModels.length,
      itemBuilder: (context, index) {
        final product = productDomainModels[index];
        return Card(
          elevation: 4.0,
          child: InkWell(
            onTap: () {
              GoRouter.of(context).pushNamed('details', extra: product);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  product.image,
                  width: MediaQuery.sizeOf(context).width / 2.5,
                  height: MediaQuery.sizeOf(context).width / 2.5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
