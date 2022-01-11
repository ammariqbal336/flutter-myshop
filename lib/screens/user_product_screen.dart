import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/screens/edit_product_screen.dart';
import '../widgets/appdrawer.dart';
import '../widgets/user_product_item.dart';
import '../provider/product_provider.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = "/product";
  const UserProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
            itemCount: productData.items.length,
            itemBuilder: (ctx, i) => Column(
              children: [
                UserProductItem(
                      product: productData.items[i],
                ),
                const Divider(),
              ],
            )),
      ),
    );
  }
}
