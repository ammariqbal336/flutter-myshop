import 'package:provider/provider.dart';

import 'package:flutter/foundation.dart';
import 'package:shop/provider/product.dart';

class Cart {
  final String id;
  final String title;
  final double price;
  final int quantity;

  Cart({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });
}

class CartProvider with ChangeNotifier {
  Map<String, Cart> _items = {};

  Map<String, Cart> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double amount = 0.0;

    _items.forEach((key, value) {
      amount += value.price * value.quantity;
    });
    return amount;
  }

  void addCartItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (value) => Cart(
          id: value.id,
          title: value.title,
          price: value.price,
          quantity: value.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => Cart(
            id: DateTime.now().toString(),
            title: product.title,
            price: product.price,
            quantity: 1),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if ((_items[productId]?.quantity ?? 0) > 1) {
      _items.update(
          productId,
          (product) => Cart(
              id: product.id,
              title: product.title,
              price: product.price,
              quantity: (product.quantity - 1)));
    }
    else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
