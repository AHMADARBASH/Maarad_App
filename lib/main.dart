import 'package:flutter/material.dart';
import 'package:maarad_app/providers/auth_provider.dart';
import 'package:maarad_app/providers/cart_provider.dart';
import 'package:maarad_app/providers/counter_provider.dart';
import 'package:maarad_app/providers/products_provider.dart';
import 'package:maarad_app/screens/auth_screen.dart';
import 'package:maarad_app/screens/cart_screen.dart';
import 'package:maarad_app/screens/main_screen.dart';
import 'package:maarad_app/screens/categories/drinks_screen.dart';
import 'package:maarad_app/screens/categories/pastries_screen.dart';
import 'package:maarad_app/screens/product_details_screen.dart';
import 'package:maarad_app/screens/categories/sandwiches_screen.dart';
import 'package:provider/provider.dart';
import 'package:maarad_app/screens/orders_screen.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: [SystemUiOverlay.bottom]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CounterProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: ThemeData(
            // canvasColor: Colors.yellow[100],
            textTheme: const TextTheme(
                bodyText2: TextStyle(
              color: Colors.white,
            )),
            appBarTheme: const AppBarTheme(
              centerTitle: true,
            ),
            androidOverscrollIndicator: AndroidOverscrollIndicator.glow,
            colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: Colors.yellow[700],
                secondary: Colors.yellow[100],
                error: Colors.red)),
        darkTheme: ThemeData.dark(),
        home: const AuthScreen(),
        routes: {
          SandwichScreen.routeName: (ctx) => const SandwichScreen(),
          CategoriesScreen.routeName: (ctx) => const CategoriesScreen(),
          DrinksScreen.routeName: (ctx) => const DrinksScreen(),
          PastriesScreen.routeName: (ctx) => const PastriesScreen(),
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
          CartScreen.routeName: (ctx) => const CartScreen(),
          OrdersScreen.routeName: (ctx) => const OrdersScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const CategoriesScreen();
  }
}
