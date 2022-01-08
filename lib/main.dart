import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/order_provider.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/screens/order_screen.dart';
import 'package:shop/screens/product_detail_screen.dart';
import '../provider/cart_provider.dart';
import '../provider/product_provider.dart';
import './screens/product_overview_screen.dart';
import './screens/order_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrderProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(secondary: Colors.deepOrange),
          fontFamily: 'Lato'
        ),
        home:  ProductOverviewScreen(),
        routes: {
          CartScreen.routeName : (ctx) => const CartScreen(),
          ProductDetail.routeName : (ctx) => const ProductDetail(),
          OrderScreen.routeName : (ctx) => const OrderScreen(),

        },
      ),
    
    
    );
  }
}

