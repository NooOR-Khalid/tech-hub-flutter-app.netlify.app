import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com/products';
  static const String _cacheKey = 'cached_products';

  static Future<List<Product>> fetchProductsFromApi() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _getBackupProducts();
  }

  static List<Product> _getBackupProducts() {
    final List<Map<String, dynamic>> backup = [
      {
        "id": "p1",
        "category": "Laptops",
        "title": "Gaming Laptop PRO Ultra",
        "price": 2199.99,
        "imageUrl": "assets/images/c1.jpg",
        "description": "High-performance RGB gaming laptop.",
      },
      {
        "id": "p2",
        "category": "Laptops",
        "title": "MacBook Air M3",
        "price": 1249.50,
        "imageUrl": "assets/images/c2.jpg",
        "description": "Sleek and powerful productivity.",
      },
      {
        "id": "p3",
        "category": "Watches",
        "title": "Apple Watch Series 10",
        "price": 499.00,
        "imageUrl": "assets/images/w1.jpg",
        "description": "Stay connected in style.",
      },
      {
        "id": "p3_2",
        "category": "Watches",
        "title": "Smart Watch S10 Pro",
        "price": 550.00,
        "imageUrl": "assets/images/w2.jpg",
        "description": "Latest series with sensors.",
      },
      {
        "id": "p4",
        "category": "Accessories",
        "title": "Mechanical Keyboard RGB",
        "price": 145.00,
        "imageUrl": "assets/images/s1.jpg",
        "description": "Tactile typing experience.",
      },
      {
        "id": "p4_2",
        "category": "Accessories",
        "title": "Gaming Mouse Wireless",
        "price": 89.99,
        "imageUrl": "assets/images/s2.jpg",
        "description": "High-precision optical sensor.",
      },
      {
        "id": "p5",
        "category": "Audio",
        "title": "Wireless Headphones ANC",
        "price": 299.00,
        "imageUrl": "assets/images/a1.jpg",
        "description": "Pure sound with noise cancellation.",
      },
      {
        "id": "p6",
        "category": "Audio",
        "title": "Bluetooth Speaker Waterproof",
        "price": 69.99,
        "imageUrl": "assets/images/a2.jpg",
        "description": "Portable with deep bass.",
      },
    ];
    return backup.map((json) => Product.fromJson(json)).toList();
  }
}
