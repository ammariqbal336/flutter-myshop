import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';

class CartItem extends StatelessWidget {
  final Cart cart;
  final String productId;
  const CartItem({required this.cart, required this.productId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cart.id),
      background: Container(
        padding: const EdgeInsets.only(right: 15),
        margin: const EdgeInsets.only(right: 15),
        color: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (dirextion) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text("Are you sure?"),
                  content: const Text("you want to remove this item from cart?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text("No"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text("Yes"),
                    ),
                  ],
                ));
      },
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(child: Text("\$${cart.price}")),
              ),
            ),
            title: Text(cart.title),
            subtitle: Text("${(cart.price * cart.quantity)}"),
            trailing: Text("${cart.quantity} x"),
          ),
        ),
      ),
    );
  }
}
