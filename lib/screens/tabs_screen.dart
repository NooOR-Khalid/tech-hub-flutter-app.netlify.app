import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart'; // تأكدي من استيراد ملف الثيم
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              FirebaseAuth.instance.signOut();
            },
            child: const Text('Yes', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_idx]['title'] as String),
        actions: [
          // إضافة زر الثيم هنا
          Consumer<ThemeProvider>(
            builder: (ctx, themeProvider, _) => IconButton(
              icon: Icon(
                themeProvider.isDarkMode
                    ? Icons.wb_sunny
                    : Icons.nightlight_round,
              ),
              onPressed: () => themeProvider.toggleTheme(),
            ),
          ),
          // زر تسجيل الخروج
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => _showLogoutDialog(context),
          ),
          if (_idx != 3)
            Consumer<CartProvider>(
              builder: (ctx, cartData, child) => Badge(
                label: Text(cartData.totalItemsCount.toString()),
                isLabelVisible: cartData.totalItemsCount > 0,
                backgroundColor: Colors.cyanAccent,
                textColor: Colors.black,
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () => setState(() => _idx = 3),
                ),
              ),
            ),
          const SizedBox(width: 8),
        ],
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
