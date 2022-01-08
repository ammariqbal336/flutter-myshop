import 'package:flutter/foundation.dart';

import 'cart_provider.dart';

class OrderItem {
  final String Id;
  final double amount;
  final List<Cart> product;
  final DateTime dateTime;

  OrderItem(
      {required this.Id,
      required this.amount,
      required this.dateTime,
      required this.product});
}

class OrderProvider with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orderList {
    return [..._orders];
  }

  void addOrder(List<Cart> cartlist, double amount) {
    if(cartlist.isNotEmpty){
        _orders.insert(
          0,
          OrderItem(
              Id: DateTime.now().toString(),
              dateTime: DateTime.now(),
              product: cartlist,
              amount: amount),
        );
        notifyListeners();
    }
  }
}
