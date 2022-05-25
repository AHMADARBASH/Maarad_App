import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:maarad_app/providers/cart_provider.dart';
import 'package:maarad_app/widgets/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/CartScreen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return ColorfulSafeArea(
        color: Theme.of(context).colorScheme.primary,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Your Cart'),
          ),
          body: Column(children: [
            Expanded(
                child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartItem(
                  id: cart.items.values.toList()[i].id,
                  productId: cart.items.keys.toList()[i],
                  price: cart.items.values.toList()[i].price,
                  qty: cart.items.values.toList()[i].qty,
                  title: cart.items.values.toList()[i].title),
            )),
            Card(
              elevation: 10,
              color: Theme.of(context).colorScheme.primary,
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Chip(
                      avatar: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: const Icon(
                          Icons.attach_money,
                          color: Colors.white,
                        ),
                      ),
                      label: Text(
                        ' ${cart.totalAmount.toStringAsFixed(0)}',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Order now',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ))
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}
