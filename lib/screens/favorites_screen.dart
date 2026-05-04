import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/product_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favs = Provider.of<ProductsProvider>(context).favoriteItems;
    final deviceWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = deviceWidth > 1200 ? 4 : (deviceWidth > 800 ? 3 : 2);

    return favs.isEmpty
        ? const Center(
            child: Text(
              'No favorites yet!',
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: favs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 0.75,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: favs[i],
              child: const ProductItem(),
            ),
          );
  }
}
