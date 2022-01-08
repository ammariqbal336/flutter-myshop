import 'package:flutter/material.dart';
import 'package:shop/screens/order_screen.dart';
class AppDrawer extends StatelessWidget {
  const AppDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(title: const Text("Happy Shopping!"),automaticallyImplyLeading: false,),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("Shop"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Order"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}