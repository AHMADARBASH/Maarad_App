import 'package:flutter/Material.dart';
import 'package:maarad_app/models/cart.dart';
import '../models/cart.dart';

class CartProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  Map<String, Cart> _items = {};

  Map<String, Cart> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cart) {
      total += cart.price;
    });
    return total;
  }

  void addItem(
      {String? productID, double? price, String? title, int? totalqty}) {
    if (_items.containsKey(productID)) {
      _items.update(
          productID!,
          (value) => Cart(
              id: value.id,
              productId: productID,
              title: value.title,
              price: value.price * totalqty!,
              qty: totalqty));
    } else {
      _items.putIfAbsent(
        productID!,
        () => Cart(
            productId: productID,
            id: DateTime.now().toString(),
            title: title!,
            price: price! * totalqty!,
            qty: totalqty),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
}
