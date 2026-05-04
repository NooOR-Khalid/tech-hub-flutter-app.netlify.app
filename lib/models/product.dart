import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id, category, title, description, imageUrl;
  final double price;
  bool isFavorite;

  Product({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
