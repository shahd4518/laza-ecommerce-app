import 'package:flutter/material.dart';
import '../product/product_detail_screen.dart';
import '../product/product_model.dart';
import '../cart/cart_screen.dart';
import '../favorites/favorites_screen.dart';
import '../profile/profile_screen.dart';
import '../product/product_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final ProductService _productService = ProductService();

  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _loading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() async {
    try {
      final products = await _productService.fetchProducts();
      setState(() {
        _products = products;
        _filteredProducts = products;
        _loading = false;
      });
      print("✅ Products loaded: ${_products.length}");
    } catch (e) {
      print("⚠️ Error fetching products: $e");
      setState(() => _loading = false);
    }
  }

  void _search(String query) {
    final filtered = _products
        .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() => _filteredProducts = filtered);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      _productListScreen(),
      CartScreen(),
      FavoritesScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Laza App')),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  Widget _productListScreen() {
    if (_loading) return Center(child: CircularProgressIndicator());
    if (_filteredProducts.isEmpty) return Center(child: Text('No products found'));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search products...',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.search),
            ),
            onChanged: _search,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredProducts.length,
            itemBuilder: (context, index) {
              final product = _filteredProducts[index];
              return ListTile(
                leading: Image.network(product.image, width: 50, height: 50),
                title: Text(product.title),
                subtitle: Text('\$${product.price}'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
