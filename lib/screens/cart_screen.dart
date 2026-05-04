import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items.values.toList();
    final ids = cart.items.keys.toList();

    return Column(
      children: [
        Card(
          color: const Color(0xFF1E1E1E),
          margin: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.cyanAccent, width: 0.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(width: 15),
                Chip(
                  label: Text(
                    '\$${cart.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Colors.cyanAccent,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: cart.totalAmount <= 0 ? null : () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                  ),
                  child: const Text(
                    'CHECKOUT',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: cart.items.isEmpty
              ? const Center(
                  child: Text(
                    'Your cart is empty!',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (ctx, i) => Dismissible(
                    key: ValueKey(ids[i]),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) => cart.removeItem(ids[i]),
                    background: Container(
                      color: Colors.redAccent.withValues(
                        alpha: 0.1,
                      ), // تحديث هنا لحل التنبيه
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(
                        Icons.delete_forever,
                        color: Colors.redAccent,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 800),
                        child: Card(
                          color: const Color(0xFF1E1E1E),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(
                                cartItems[i].imageUrl,
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                            title: Text(
                              cartItems[i].title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Text(
                              '\$${(cartItems[i].price * cartItems[i].quantity).toStringAsFixed(2)}',
                              style: const TextStyle(color: Colors.cyanAccent),
                            ),
                            trailing: SizedBox(
                              width: 120,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                      color: Colors.redAccent,
                                    ),
                                    onPressed: () =>
                                        cart.removeSingleItem(ids[i]),
                                  ),
                                  Text(
                                    '${cartItems[i].quantity}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.add_circle_outline,
                                      color: Colors.cyanAccent,
                                    ),
                                    onPressed: () => cart.addItem(
                                      ids[i],
                                      cartItems[i].price,
                                      cartItems[i].title,
                                      cartItems[i].imageUrl,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
