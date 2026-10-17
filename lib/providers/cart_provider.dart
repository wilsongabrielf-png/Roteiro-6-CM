
import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => List.unmodifiable(_products);

  int get totalItems => _products.length;

  double get totalPrice {
    double total = 0;

    for (final product in _products) {
      total += product.preco;
    }

    return total;
  }

  void addProduct(Product produto) {
    if (produto.nome.trim().isEmpty || produto.preco < 0) {
      return;
    }

    _products.add(produto);
    notifyListeners();
  }

  void removeProduct(int index) {
    if (index < 0 || index >= _products.length) {
      return;
    }

    _products.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _products.clear();
    notifyListeners();
  }
}
