import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  static const String routeName = '/OrdersScreen';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Theme.of(context).colorScheme.primary,
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text('Orders')),
      ),
    );
  }
}
