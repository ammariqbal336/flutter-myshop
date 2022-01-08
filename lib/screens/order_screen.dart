import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/order_provider.dart' show OrderProvider;
import '../widgets/order_item.dart';
import '../widgets/appdrawer.dart';
class OrderScreen extends StatelessWidget {
  static const routeName = "/order";
  const OrderScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final order = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Order list"),),
      drawer: const AppDrawer(),
      body: ListView.builder(itemCount: order.orderList.length,itemBuilder: (context,i) => OrderItem(orderItem: order.orderList[i],)),
    );
  }
}