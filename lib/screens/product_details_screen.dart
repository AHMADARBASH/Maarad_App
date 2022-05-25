// ignore_for_file: use_key_in_widget_constructors

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:maarad_app/providers/cart_provider.dart';
import 'package:maarad_app/providers/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:maarad_app/providers/counter_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const String routeName = '/productDetailsScreen';
  @override
  Widget build(BuildContext context) {
    final routedID = ModalRoute.of(context)!.settings.arguments as String;
    final routedProdcut = Provider.of<ProductsProvider>(context, listen: false)
        .findByID(routedID);
    final itemsCounter = Provider.of<CounterProvider>(context, listen: false);
    return ColorfulSafeArea(
      color: Theme.of(context).colorScheme.primary,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    itemsCounter.resetCounter();
                  },
                ),
              ),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: (MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top) *
                      0.5,
                  child: Hero(
                    tag: routedProdcut.id,
                    child: Image(
                      image: NetworkImage(routedProdcut.imageURL),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    routedProdcut.title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      routedProdcut.description,
                      overflow: TextOverflow.visible,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const Counter(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({Key? key, counter}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  @override
  Widget build(BuildContext context) {
    final routedID = ModalRoute.of(context)!.settings.arguments as String;
    final routedProdcut = Provider.of<ProductsProvider>(context, listen: false)
        .findByID(routedID);
    final itemsCounter = Provider.of<CounterProvider>(context);
    final cartprovider = Provider.of<CartProvider>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
                onPressed: () {
                  itemsCounter.decrement();
                },
                child: Text(
                  '-',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 40),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Text(
                itemsCounter.value.toString(),
                style: const TextStyle(color: Colors.black, fontSize: 28),
              ),
            ),
            OutlinedButton(
                onPressed: () {
                  itemsCounter.increment();
                },
                child: Text(
                  '+',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 40),
                ))
          ],
        ),
        Center(
            child: Text(
          'Total Price: ${itemsCounter.value * routedProdcut.unitPrice}',
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary, fontSize: 28),
        )),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        ElevatedButton.icon(
            onPressed: () {
              cartprovider.addItem(
                  totalqty: itemsCounter.value,
                  productID: routedProdcut.id,
                  price: routedProdcut.unitPrice,
                  title: routedProdcut.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Items has been added to cart'),
                    duration: Duration(seconds: 1)),
              );
            },
            label: const Text('Add to Cart'),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            icon: const Icon(
              Icons.add_shopping_cart,
              color: Colors.white,
            )),
      ],
    );
  }
}
