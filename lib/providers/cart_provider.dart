import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';

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
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get totalItemsCount =>
      _items.values.fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount => _items.values.fold(
    0.0,
    (sum, item) => sum + (item.price * item.quantity),
  );

  Future<void> fetchAndSetCart() async {
    final dataList = await DBHelper.getData('cart_items');
    _items = {
      for (var item in dataList)
        item['id']: CartItem(
          id: item['id'],
          title: item['title'],
          price: item['price'],
          imageUrl: item['image'],
          quantity: item['quantity'],
        ),
    };
    notifyListeners();
  }

  Future<void> addItem(
    String productId,
    double price,
    String title,
    String imageUrl,
  ) async {
    if (_items.containsKey(productId)) {
      final updatedItem = CartItem(
        id: productId,
        title: title,
        price: price,
        quantity: _items[productId]!.quantity + 1,
        imageUrl: imageUrl,
      );
      _items.update(productId, (ex) => updatedItem);
      // التعديل: استخدام دالة تحديث في قاعدة البيانات
      await DBHelper.update('cart_items', productId, {
        'quantity': updatedItem.quantity,
      });
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          title: title,
          price: price,
          quantity: 1,
          imageUrl: imageUrl,
        ),
      );
      await DBHelper.insert('cart_items', {
        'id': productId,
        'title': title,
        'price': price,
        'image': imageUrl,
        'quantity': 1,
      });
    }
    notifyListeners();
  }

  Future<void> removeSingleItem(String productId) async {
    if (!_items.containsKey(productId)) return;

    if (_items[productId]!.quantity > 1) {
      final updatedItem = CartItem(
        id: productId,
        title: _items[productId]!.title,
        price: _items[productId]!.price,
        quantity: _items[productId]!.quantity - 1,
        imageUrl: _items[productId]!.imageUrl,
      );
      _items.update(productId, (ex) => updatedItem);
      await DBHelper.update('cart_items', productId, {
        'quantity': updatedItem.quantity,
      });
    } else {
      _items.remove(productId);
      await DBHelper.delete('cart_items', productId);
    }
    notifyListeners();
  }

  Future<void> removeItem(String productId) async {
    _items.remove(productId);
    await DBHelper.delete('cart_items', productId);
    notifyListeners();
  }
}
