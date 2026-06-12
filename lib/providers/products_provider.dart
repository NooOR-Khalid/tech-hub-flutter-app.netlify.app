import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems => _items.where((p) => p.isFavorite).toList();

  List<Product> findByCategory(String cat) {
    return _items
        .where(
          (p) => p.category.toLowerCase().trim() == cat.toLowerCase().trim(),
        )
        .toList();
  }

  Product findById(String id) {
    return _items.firstWhere((p) => p.id == id, orElse: () => _items[0]);
  }

  Future<void> fetchProducts() async {
    try {
      final snapshot = await _firestore.collection('products').get();
      final List<Product> loadedProducts = [];

      for (var doc in snapshot.docs) {
        final data = doc.data();
        loadedProducts.add(
          Product(
            id: doc.id,
            title: data['title'] ?? '',
            price: (data['price'] ?? 0).toDouble(),
            category: data['category'] ?? '',
            imageUrl: data['imageUrl'] ?? '',
            description: data['description'] ?? '',
          ),
        );
      }
      _items = loadedProducts;
      await fetchAndSetFavorites();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void toggleFavoriteStatus(String productId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final prodIndex = _items.indexWhere((p) => p.id == productId);
    if (prodIndex >= 0) {
      final oldStatus = _items[prodIndex].isFavorite;
      _items[prodIndex].isFavorite = !oldStatus;
      notifyListeners();

      try {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('favorites')
            .doc(productId)
            .set({'isFavorite': _items[prodIndex].isFavorite});
      } catch (error) {
        _items[prodIndex].isFavorite = oldStatus;
        notifyListeners();
      }
    }
  }

  Future<void> fetchAndSetFavorites() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final snapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .get();

    final favoriteIds = snapshot.docs
        .where((doc) => doc.data()['isFavorite'] == true)
        .map((doc) => doc.id)
        .toList();

    for (var product in _items) {
      product.isFavorite = favoriteIds.contains(product.id);
    }
    notifyListeners();
  }
}
