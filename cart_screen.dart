import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart_service.dart';

class CartScreen extends StatelessWidget {
  final CartService _cartService = CartService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _cartService.getCartItems(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final docs = snapshot.data!.docs;
          if (docs.isEmpty) return Center(child: Text('Your cart is empty'));

          double subtotal = docs.fold(0, (sum, doc) => sum + doc['price'] * doc['quantity']);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final item = docs[index];
                    return ListTile(
                      leading: Image.network(item['image'], width: 50, height: 50),
                      title: Text(item['title']),
                      subtitle: Text('Qty: ${item['quantity']} - \$${item['price']}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _cartService.removeFromCart(int.parse(item.id)),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('Subtotal: \$${subtotal.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        await _cartService.clearCart();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Checkout successful')));
                      },
                      child: Text('Checkout'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
