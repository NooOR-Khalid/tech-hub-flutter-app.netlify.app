import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/products_grid.dart';

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  late Future<void> _productsFuture;

  @override
  void initState() {
    super.initState();
    // جلب البيانات مع التأكد من عدم تكرارها إذا كانت موجودة
    _productsFuture = Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // تم إزالة اللون الثابت، ليعتمد التطبيق على خلفية الـ Theme
      body: FutureBuilder(
        future: _productsFuture,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          } else if (dataSnapshot.hasError) {
            return const Center(child: Text('An error occurred!'));
          } else {
            return const ProductsGrid();
          }
        },
      ),
    );
  }
}
