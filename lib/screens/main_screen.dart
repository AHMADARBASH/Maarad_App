import 'package:badges/badges.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:maarad_app/providers/auth_provider.dart';
import 'package:maarad_app/providers/cart_provider.dart';
import 'package:maarad_app/screens/cart_screen.dart';
import 'package:maarad_app/screens/categories/drinks_screen.dart';
import 'package:maarad_app/screens/categories/pastries_screen.dart';
import 'package:maarad_app/screens/categories/sandwiches_screen.dart';
import 'package:maarad_app/screens/orders_screen.dart';
import 'package:maarad_app/widgets/category_item.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  static const String routeName = '/CategoriesScreen';
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  void logOut(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'Logout',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            content: const Text('are you sure to logout?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Provider.of<Auth>(context, listen: false).logout();
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                  child: const Text('yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('no'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Theme.of(context).colorScheme.primary,
      child: Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     Provider.of<Auth>(context, listen: false).PrintToken();
          //   },
          // ),
          drawer: Drawer(
            child: ListView(
              children: [
                Container(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 40,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      FutureBuilder(
                          future: Provider.of<Auth>(context, listen: false)
                              .userName,
                          builder: ((ctx, snapshot) {
                            return Text(snapshot.data.toString(),
                                style: const TextStyle(fontSize: 25));
                          }))
                    ],
                  )),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[600]!,
                        spreadRadius: 1,
                        blurRadius: 3,
                      ),
                    ],
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(10)),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  height: (MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top) *
                      0.25,
                ),
                const Divider(color: Colors.transparent),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(OrdersScreen.routeName);
                  },
                  leading: Icon(FontAwesome.credit_card,
                      color: Theme.of(context).colorScheme.primary),
                  title: const Text(
                    'Orders',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const Divider(),
                ListTile(
                  onTap: () {
                    logOut(context);
                  },
                  leading: Icon(Entypo.logout,
                      color: Theme.of(context).colorScheme.primary),
                  title: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          appBar: AppBar(
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
            title: const Text('SARC IT Order'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: ListView(
              addAutomaticKeepAlives: false,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(SandwichScreen.routeName);
                  },
                  child: CategoryItem(
                      title: 'Sandwiches', imageURL: 'images/sandwiches2.jpg'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(DrinksScreen.routeName);
                  },
                  child: CategoryItem(
                      title: 'Drinks', imageURL: 'images/drinks.png'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(PastriesScreen.routeName);
                  },
                  child: CategoryItem(
                      title: 'Pastries', imageURL: 'images/pastries.jpg'),
                ),
              ],
            ),
          )),
    );
  }
}
