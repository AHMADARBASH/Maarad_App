import 'package:flutter/material.dart';
import 'package:maarad_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int qty;
  final String title;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  CartItem({
    required this.id,
    required this.productId,
    required this.price,
    required this.qty,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Dismissible(
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  content: const Text(
                      'Do you want to delete this item from the cart?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Yes')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('No')),
                  ],
                ));
      },
      onDismissed: (direction) {
        cart.removeItem(productId);
      },
      key: ValueKey(id),
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(
            Icons.delete_forever,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 4,
          child: ListTile(
            leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      (cart.items[productId]!.price /
                                  cart.items[productId]!.qty)
                              .toStringAsFixed(0) +
                          ' \$',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )),
            title: Text(
              cart.items[productId]!.title,
            ),
            subtitle: Text(
                'Total:  ${cart.items[productId]!.price.toStringAsFixed(0)} \$'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${cart.items[productId]!.qty} x',
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
