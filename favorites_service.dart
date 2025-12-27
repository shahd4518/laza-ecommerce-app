import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../product/product_model.dart';

class FavoritesService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addToFavorites(Product product) async {
    await _db.collection('favorites').doc(_userId).collection('items').doc(product.id.toString()).set({
      'title': product.title,
      'price': product.price,
      'image': product.image,
    });
  }

  Future<void> removeFromFavorites(int productId) async {
    await _db.collection('favorites').doc(_userId).collection('items').doc(productId.toString()).delete();
  }

  Stream<QuerySnapshot> getFavorites() {
    return _db.collection('favorites').doc(_userId).collection('items').snapshots();
  }
}
