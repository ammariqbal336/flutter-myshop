import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/product.dart';
import '../widgets/product_item.dart';
import '../provider/product_provider.dart';
class ProductGrid extends StatelessWidget {
  final bool isFavorite;
  const ProductGrid({
    required this.isFavorite ,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData =  Provider.of<ProductProvider>(context);
    final products = isFavorite ? productData.favoriteItems : productData.items ;
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 4),
      itemBuilder: (ctx, index) =>   ChangeNotifierProvider.value(value: products[index], child: ProductItem(),) ,
    );
  }
}
