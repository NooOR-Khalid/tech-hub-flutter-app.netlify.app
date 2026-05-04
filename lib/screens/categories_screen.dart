import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/product_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String? _selected;
  final List<Map<String, dynamic>> _cats = [
    {'title': 'Laptops', 'icon': Icons.laptop_mac, 'color': Colors.cyanAccent},
    {
      'title': 'Watches',
      'icon': Icons.watch_rounded,
      'color': Colors.orangeAccent,
    },
    {
      'title': 'Accessories',
      'icon': Icons.headphones,
      'color': Colors.purpleAccent,
    },
    {
      'title': 'Audio',
      'icon': Icons.speaker_group,
      'color': Colors.greenAccent,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProductsProvider>(context);
    final deviceWidth = MediaQuery.of(context).size.width;

    // حساب عدد الأعمدة بناءً على العرض
    int crossAxisCount = deviceWidth > 1200 ? 4 : (deviceWidth > 800 ? 3 : 2);

    if (_selected != null) {
      final prods = prov.findByCategory(_selected!);
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.cyanAccent,
                  ),
                  onPressed: () => setState(() => _selected = null),
                ),
                Text(
                  _selected!,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
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
            ),
          ),
        ],
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _cats.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1.1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (ctx, i) => GestureDetector(
        onTap: () => setState(() => _selected = _cats[i]['title']),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(_cats[i]['icon'], size: 45, color: _cats[i]['color']),
              const SizedBox(height: 15),
              Text(
                _cats[i]['title'],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
