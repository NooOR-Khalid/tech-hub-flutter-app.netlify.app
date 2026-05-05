import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // إضافة المكتبة
import '../providers/cart_provider.dart'; // تأكد من مسار الملف الصحيح
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
                // استخدام Consumer لمراقبة عدد عناصر السلة
                Consumer<CartProvider>(
                  builder: (ctx, cartData, child) => Badge(
                    label: Text(cartData.totalItemsCount.toString()),
                    isLabelVisible: cartData.totalItemsCount > 0,
                    backgroundColor: Colors.cyanAccent, // لون مميز للعداد
                    textColor: Colors.black,
                    child: IconButton(
                      icon: const Icon(Icons.shopping_cart_outlined),
                      onPressed: () => setState(() => _idx = 3),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
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
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            activeIcon: Icon(Icons.grid_view),
            label: 'Categories',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            // إضافة عداد أيضاً في القائمة السفلية لجمالية التصميم
            icon: Consumer<CartProvider>(
              builder: (ctx, cartData, child) => Badge(
                label: Text(cartData.totalItemsCount.toString()),
                isLabelVisible: cartData.totalItemsCount > 0,
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
            activeIcon: const Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
