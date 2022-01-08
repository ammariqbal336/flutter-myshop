import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import '../screens/cart_screen.dart';
import '../widgets/appdrawer.dart';
import '../widgets/badge.dart';

import '../widgets/product_grid.dart';

enum Filters {
  Favorite,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyShop"),
        actions: <Widget>[
          Consumer<CartProvider>(
            builder: (_, cartdata, ch) => Badge(
              child: ch ?? Container(),
              value: cartdata.itemCount.toString(),
            ),
            child:  IconButton(icon: const Icon(Icons.shopping_cart),onPressed: (){
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },),
          ),
          PopupMenuButton(
            onSelected: (Filters selectedValue) {
              setState(() {
                if (selectedValue == Filters.Favorite) {
                  isFavorite = true;
                } else {
                  isFavorite = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text("Only Favorite"),
                value: Filters.Favorite,
              ),
              const PopupMenuItem(
                child: Text("All"),
                value: Filters.All,
              ),
            ],
          ),
          
        ],
      ),
      drawer: const AppDrawer(),
      body: ProductGrid(
        isFavorite: isFavorite,
      ),
    );
  }
}
