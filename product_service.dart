import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product_model.dart';

class ProductService {
  final String apiUrl = 'https://fakestoreapi.com/products';

  // Fetch all products
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Fetch product by ID
  Future<Product> fetchProductById(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));
    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load product');
    }
  }
}
