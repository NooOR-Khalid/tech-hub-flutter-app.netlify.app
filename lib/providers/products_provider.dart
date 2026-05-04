import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductsProvider with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      category: 'Laptops',
      title: 'Gaming Laptop',
      price: 1500.0,
      imageUrl: 'assets/images/c1.jpg',
      description: 'High-performance RGB gaming laptop.',
    ),
    Product(
      id: 'p2',
      category: 'Laptops',
      title: 'MacBook Air',
      price: 999.0,
      imageUrl: 'assets/images/c2.jpg',
      description: 'Sleek and powerful productivity.',
    ),
    Product(
      id: 'p3',
      category: 'Watches',
      title: 'Apple Watch',
      price: 399.0,
      imageUrl: 'assets/images/w1.jpg',
      description: 'Stay connected in style.',
    ),
    Product(
      id: 'p3_2',
      category: 'Watches',
      title: 'Smart Watch S9',
      price: 450.0,
      imageUrl: 'assets/images/w2.jpg',
      description: 'Latest series with sensors.',
    ),
    Product(
      id: 'p4',
      category: 'Accessories',
      title: 'Mechanical Keyboard',
      price: 129.0,
      imageUrl: 'assets/images/s1.jpg',
      description: 'Tactile typing experience.',
    ),
    Product(
      id: 'p4_2',
      category: 'Accessories',
      title: 'Gaming Mouse',
      price: 79.0,
      imageUrl: 'assets/images/s2.jpg',
      description: 'High-precision optical sensor.',
    ),
    Product(
      id: 'p5',
      category: 'Audio',
      title: 'Wireless Headphones',
      price: 250.0,
      imageUrl: 'assets/images/a1.jpg',
      description: 'Pure sound with noise cancellation.',
    ),
    Product(
      id: 'p6',
      category: 'Audio',
      title: 'Bluetooth Speaker',
      price: 59.0,
      imageUrl: 'assets/images/a2.jpg',
      description: 'Portable with deep bass.',
    ),
  ];

  List<Product> get items => [..._items];
  List<Product> get favoriteItems => _items.where((p) => p.isFavorite).toList();
  Product findById(String id) => _items.firstWhere((p) => p.id == id);
  List<Product> findByCategory(String cat) => _items
      .where((p) => p.category.toLowerCase().trim() == cat.toLowerCase().trim())
      .toList();
}
