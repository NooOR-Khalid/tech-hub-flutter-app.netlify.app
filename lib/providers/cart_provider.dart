import 'package:flutter/material.dart';

class CartItem {
  final String id, title, imageUrl;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  // التعديل: حساب إجمالي عدد القطع (مثلاً 2 لابتوب + 1 هاتف = 3)
  int get totalItemsCount {
    var total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.quantity;
    });
    return total;
  }

  double get totalAmount => _items.values.fold(
    0.0,
    (sum, item) => sum + (item.price * item.quantity),
  );

  void addItem(String productId, double price, String title, String imageUrl) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (ex) => CartItem(
          id: ex.id,
          title: ex.title,
          price: ex.price,
          quantity: ex.quantity + 1,
          imageUrl: ex.imageUrl,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
          imageUrl: imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) return;
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (ex) => CartItem(
          id: ex.id,
          title: ex.title,
          price: ex.price,
          quantity: ex.quantity - 1,
          imageUrl: ex.imageUrl,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
}
