import 'package:flutter/material.dart';
import 'package:storelist/store/domain/product_domain_model.dart';


class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.productDomainModel});

  final ProductDomainModel productDomainModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Product Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Image.network(  
                productDomainModel.image,
                height: 200,
                width: 200,
              ),
            ),
            Text(productDomainModel.title),
            Text(productDomainModel.description),
            Text('\$${productDomainModel.price.toString()}'),],
        ),
      ),
    );
  }


}
