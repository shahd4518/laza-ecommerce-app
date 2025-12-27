import 'package:flutter/material.dart';
import '../product/product_model.dart';
import '../cart/cart_service.dart';
import '../favorites/favorites_service.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final CartService _cartService = CartService();
  final FavoritesService _favoritesService = FavoritesService();

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(product.image, height: 200),
            SizedBox(height: 16),
            Text(product.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('\$${product.price}', style: TextStyle(fontSize: 18, color: Colors.green)),
            SizedBox(height: 16),
            Expanded(child: SingleChildScrollView(child: Text(product.description))),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    await _cartService.addToCart(product);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Added to cart')));
                  },
                  icon: Icon(Icons.shopping_cart),
                  label: Text('Add to Cart'),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await _favoritesService.addToFavorites(product);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Added to favorites')));
                  },
                  icon: Icon(Icons.favorite),
                  label: Text('Favorite'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
