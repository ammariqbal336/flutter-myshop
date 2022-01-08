import 'package:flutter/material.dart';
import '../provider/product.dart';
class ProductDetail extends StatelessWidget {
  static String routeName = "/productDetail";
  const ProductDetail({ Key? key }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Column(
        children: [
          Image.network(product.imageUrl,width: double.infinity,height: 300,fit:BoxFit.cover),
          const SizedBox(height: 10,),
          Text("\$${product.price}",style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColor,),),
          const SizedBox(height: 10,),
          Text(product.description,textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}