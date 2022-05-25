import 'package:flutter/Material.dart';
import 'package:maarad_app/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  Future<void> fetchProducts(String category) async {
    var url = Uri.parse(
        'http://82.137.255.183:3939/sarc-order/products/?category=$category');
    final List<Product> loadedProduct = [];
    try {
      final request = await http.get(url);
      var requestData = json.decode(request.body);
      for (var e in requestData) {
        loadedProduct.add(Product(
            id: e['id'].toString(),
            title: e['title'],
            category: e['category'],
            description: e['description'],
            unitPrice: e['unit_price'],
            imageURL: e['image']));
      }
      _items = loadedProduct;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Product findByID(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
