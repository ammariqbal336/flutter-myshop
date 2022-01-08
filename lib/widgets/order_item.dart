import 'dart:math';

import 'package:flutter/material.dart';

import '../provider/order_provider.dart' as ord;
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final ord.OrderItem orderItem;

  const OrderItem({required this.orderItem, Key? key}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        children: [
          ListTile(
            title: Text("\$${widget.orderItem.amount}"),
            subtitle: Text(
                DateFormat("dd-MM-yyyy").format(widget.orderItem.dateTime)),
            trailing: IconButton(
              icon:  Icon(_isExpanded ? Icons.expand_less:Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if(_isExpanded) Container(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 4),
            height: min((widget.orderItem.product.length * 20.0) +20,100),
            child: ListView(children: [
              ...widget.orderItem.product.map((e) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(e.title,style: const TextStyle(fontSize: 20),),
                  Text("${e.quantity} x \$${e.price}",style: TextStyle(fontSize: 20,color: Theme.of(context).colorScheme.secondary),),
                ],
              )).toList()
            ],),
          )
        ],
      ),
    );
  }
}
