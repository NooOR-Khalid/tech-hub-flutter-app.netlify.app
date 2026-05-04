import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final prods = Provider.of<ProductsProvider>(context).items;
    final deviceWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = deviceWidth > 1200 ? 4 : (deviceWidth > 800 ? 3 : 2);

    return GridView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: prods.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.75,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: prods[i],
        child: const ProductItem(),
      ),
    );
  }
}
