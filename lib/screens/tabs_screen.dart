import 'package:flutter/material.dart';
import './products_overview_screen.dart';
import './categories_screen.dart';
import './favorites_screen.dart';
import './cart_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;
  int _idx = 0;

  @override
  void initState() {
    _pages = [
      {'page': const ProductsOverviewScreen(), 'title': 'Tech Hub'},
      {'page': const CategoriesScreen(), 'title': 'Categories'},
      {'page': const FavoritesScreen(), 'title': 'Your Favorites'},
      {'page': const CartScreen(), 'title': 'Your Cart'},
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_idx]['title'] as String),
        actions: _idx != 3
            ? [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () => setState(() => _idx = 3),
                ),
              ]
            : [],
      ),
      body: _pages[_idx]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) => setState(() => _idx = i),
        backgroundColor: const Color(0xFF1E1E1E),
        unselectedItemColor: Colors.white70,
        selectedItemColor: Colors.cyanAccent,
        currentIndex: _idx,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            activeIcon: Icon(Icons.grid_view),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
