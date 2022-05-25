import 'package:badges/badges.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:maarad_app/providers/cart_provider.dart';
import 'package:maarad_app/providers/products_provider.dart';
import 'package:maarad_app/screens/cart_screen.dart';
import 'package:maarad_app/widgets/product_item.dart';
import 'package:provider/provider.dart';

class PastriesScreen extends StatelessWidget {
  static const String routeName = '/PastriesScreen';
  const PastriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Theme.of(context).colorScheme.primary,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pastries'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Consumer<CartProvider>(
                builder: (context, value, ch) => Badge(
                  position: BadgePosition.topEnd(end: 0, top: 0),
                  animationType: BadgeAnimationType.slide,
                  animationDuration: const Duration(milliseconds: 500),
                  child: ch!,
                  badgeColor: Colors.red,
                  badgeContent: Text(
                    value.itemCount.toString(),
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, CartScreen.routeName);
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
              ),
            )
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<ProductsProvider>(context, listen: false)
              .fetchProducts('3'),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text(
                'an error occured!',
                style: TextStyle(color: Colors.black),
              ));
            } else {
              return Consumer<ProductsProvider>(
                  builder: ((context, value, child) => ListView.builder(
                      itemCount: value.items.length,
                      itemBuilder: (ctx, i) => ProductItem(
                          productID: value.items[i].id,
                          productTitle: value.items[i].title,
                          imageURL: value.items[i].imageURL,
                          productPrice: value.items[i].unitPrice.toString(),
                          productDecription: value.items[i].description))));
            }
          },
        ),
      ),
    );
  }
}
