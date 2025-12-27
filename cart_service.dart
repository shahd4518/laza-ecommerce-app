import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../product/product_model.dart';

class CartService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addToCart(Product product, {int quantity = 1}) async {
    final docRef = _db.collection('carts').doc(_userId).collection('items').doc(product.id.toString());
    final doc = await docRef.get();
    if (doc.exists) {
      int currentQty = doc['quantity'] ?? 1;
      await docRef.update({'quantity': currentQty + quantity});
    } else {
      await docRef.set({
        'title': product.title,
        'price': product.price,
        'image': product.image,
        'quantity': quantity,
      });
    }
  }

  Future<void> removeFromCart(int productId) async {
    await _db.collection('carts').doc(_userId).collection('items').doc(productId.toString()).delete();
  }

  Stream<QuerySnapshot> getCartItems() {
    return _db.collection('carts').doc(_userId).collection('items').snapshots();
  }

  Future<void> clearCart() async {
    final snapshot = await _db.collection('carts').doc(_userId).collection('items').get();
    for (var doc in snapshot.docs) await doc.reference.delete();
  }
}
