import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';
import '../screens/edit_product_screen.dart';
import '../provider/product.dart';
class UserProductItem extends StatelessWidget {
  final Product product ;
  const UserProductItem({required this.product ,Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl), ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(onPressed: (){
              Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments: product);
            }, icon: const Icon(Icons.edit),color: Theme.of(context).primaryColor,),
            IconButton(onPressed: (){
              Provider.of<ProductProvider>(context,listen: false).deleteProduct(product.id);
            }, icon: const Icon(Icons.delete),color: Theme.of(context).errorColor,),
          ],
        ),
      ),
    ) ;
  }
}