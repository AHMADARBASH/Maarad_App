import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';

class DrinksScreen extends StatelessWidget {
  static const String routeName = '/DrinksScreen';
  const DrinksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Theme.of(context).colorScheme.primary,
      child: Scaffold(
          appBar: AppBar(
        title: const Text('Drinks'),
      )),
    );
  }
}
