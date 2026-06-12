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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      category: json['category']?.toString() ?? 'General',
      title: json['title']?.toString() ?? 'No Title',
      description: json['description']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl']?.toString() ?? 'assets/images/placeholder.jpg',
      isFavorite: false,
    );
  }

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
