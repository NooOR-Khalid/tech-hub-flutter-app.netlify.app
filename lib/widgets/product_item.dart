import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/products_provider.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    // نستخدم Consumer لتقليل إعادة البناء وتجنب أخطاء Provider
    return Consumer2<Product, CartProvider>(
      builder: (ctx, p, cart, _) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor, // استخدام لون الثيم الحالي
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                // InkWell أفضل من GestureDetector للاستجابة البصرية
                onTap: () => Navigator.of(
                  context,
                ).pushNamed(ProductDetailScreen.routeName, arguments: p.id),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child: Hero(
                    tag: p.id,
                    child: p.imageUrl.startsWith('http')
                        ? Image.network(
                            p.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          )
                        : Image.asset(
                            p.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: Column(
                children: [
                  Text(
                    p.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // زر المفضلة
                      IconButton(
                        icon: Icon(
                          p.isFavorite ? Icons.favorite : Icons.favorite_border,
                        ),
                        color: p.isFavorite ? Colors.red : Colors.cyanAccent,
                        onPressed: () => Provider.of<ProductsProvider>(
                          context,
                          listen: false,
                        ).toggleFavoriteStatus(p.id),
                      ),
                      Text(
                        '\$${p.price}',
                        style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // زر السلة
                      IconButton(
                        icon: const Icon(
                          Icons.add_shopping_cart,
                          color: Colors.cyanAccent,
                        ),
                        onPressed: () {
                          cart.addItem(p.id, p.price, p.title, p.imageUrl);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${p.title} added!'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
