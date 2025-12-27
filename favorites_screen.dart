import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'favorites_service.dart';
import '../product/product_detail_screen.dart';
import '../product/product_model.dart';

class FavoritesScreen extends StatelessWidget {
  final FavoritesService _favoritesService = FavoritesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _favoritesService.getFavorites(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final docs = snapshot.data!.docs;
          if (docs.isEmpty) return Center(child: Text('No favorites added'));

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final item = docs[index];
              final product = Product(
                id: int.parse(item.id),
                title: item['title'],
                description: '',
                image: item['image'],
                price: (item['price'] as num).toDouble(),
              );
              return ListTile(
                leading: Image.network(item['image'], width: 50, height: 50),
                title: Text(item['title']),
                subtitle: Text('\$${item['price']}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _favoritesService.removeFromFavorites(int.parse(item.id)),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)));
                },
              );
            },
          );
        },
      ),
    );
  }
}
