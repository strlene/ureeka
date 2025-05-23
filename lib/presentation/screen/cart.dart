import 'package:flutter/material.dart';
import '../../models/cart.dart';
import '../../models/perfume.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Perfume> cartPerfumes =
        ShoppingCart().items.map((item) => item.perfume).toList();

    if (cartPerfumes.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Your Cart')),
        body: Center(child: Text('No items in cart')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartPerfumes.length,
              itemBuilder: (context, index) {
                final perfume = cartPerfumes[index];

                return ListTile(
                  leading: Image.network(
                    perfume.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(perfume.name),
                  subtitle: Text('\$${perfume.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      ShoppingCart().removeItem(perfume.id);
                      (context as Element).reassemble();
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${ShoppingCart().getCartSummary()['total'].toString()}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
