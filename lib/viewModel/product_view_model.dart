import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:belajar_mvvm/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductViewModel extends ChangeNotifier {
  List<Product> _products = [];
  bool _isloading = false;

  List<Product> get products => _products;
  bool get isloading => _isloading;

  Future<void> fetchProduct() async {
    print("masuk");
    _isloading = true;
    ChangeNotifier();
    String url = 'https://fakestoreapi.com/products';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> productJson = json.decode(response.body);
        _products = productJson.map((json) => Product.fromJson(json)).toList();
        notifyListeners();
      }
    } catch (e) {
      print(e);
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

  void removeProduct() {
    _products = [];
    notifyListeners();
  }
}
