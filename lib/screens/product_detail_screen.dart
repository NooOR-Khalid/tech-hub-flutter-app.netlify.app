import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../providers/cart_provider.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final productsProj = Provider.of<ProductsProvider>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Consumer<ProductsProvider>(
          builder: (ctx, prodProvider, _) {
            final p = prodProvider.findById(id);
            return Text(p.title);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<ProductsProvider>(
          builder: (ctx, prodProvider, _) {
            final product = prodProvider.findById(id);
            return Column(
              children: [
                const SizedBox(height: 10),
                Hero(
                  tag: product.id,
                  child: product.imageUrl.startsWith('http')
                      ? Image.network(
                          product.imageUrl,
                          height: 300,
                          fit: BoxFit.contain,
                          errorBuilder: (ctx, error, stackTrace) =>
                              const SizedBox(
                                height: 300,
                                child: Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                    size: 50,
                                  ),
                                ),
                              ),
                        )
                      : Image.asset(
                          product.imageUrl,
                          height: 300,
                          fit: BoxFit.contain,
                          errorBuilder: (ctx, error, stackTrace) =>
                              const SizedBox(
                                height: 300,
                                child: Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                    size: 50,
                                  ),
                                ),
                              ),
                        ),
                ),
                const SizedBox(height: 20),
                Text(
                  '\$${product.price}',
                  style: const TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    product.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      color: product.isFavorite ? Colors.red : Colors.white60,
                      iconSize: 35,
                      onPressed: () {
                        productsProj.toggleFavoriteStatus(product.id);
                      },
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyanAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text(
                        'ADD TO CART',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        cart.addItem(
                          product.id,
                          product.price,
                          product.title,
                          product.imageUrl,
                        );
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'Added to cart',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.cyanAccent),
                            ),
                            backgroundColor: const Color(0xFF1E1E1E),
                            duration: const Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                            width: 150,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
