import 'package:flutter/material.dart';
import 'package:maarad_app/screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  final String productID;
  final String productTitle;
  final String productDecription;
  final String imageURL;
  final String productPrice;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  ProductItem(
      {required this.productID,
      required this.productTitle,
      required this.imageURL,
      required this.productPrice,
      required this.productDecription});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetailsScreen.routeName, arguments: productID);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
        child: Card(
          elevation: 3,
          child: Column(children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Hero(
                tag: productID,
                child: FadeInImage(
                  placeholder: const AssetImage('images/sandwich_fade.png'),
                  image: NetworkImage(
                    imageURL,
                  ),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 4, left: 4, right: 4, bottom: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        productTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            overflow: TextOverflow.visible,
                            fontSize: 22),
                      ),
                    ),
                    const Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 4,
                      child: Text(
                        'Price: $productPrice SP',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
