import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_ecommerce/src/features/cart/domain/cart_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_repository.g.dart';

class CartRepository {
  const CartRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static String cartPath(String userId) => 'carts/$userId/items';
  static String cartItemPath(String userId, String cartItemId) =>
      'carts/$userId/items/$cartItemId';

  // Add item to cart
  Future<void> addCartItem({
    required String userId,
    required String productId,
    required int quantity,
  }) async {
    final cartItemRef = _firestore.collection(cartPath(userId)).doc(productId);
    await cartItemRef.set({
      'productId': productId,
      'quantity': quantity,
      'addedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Update item quantity in cart
  Future<void> updateCartItemQuantity({
    required String userId,
    required String cartItemId,
    required int newQuantity,
  }) async {
    final itemRef = _firestore.doc(cartItemPath(userId, cartItemId));
    await itemRef.update({
      'quantity': newQuantity,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Remove item from cart
  Future<void> removeCartItem(
    String id, {
    required String userId,
    required String cartItemId,
  }) async {
    final itemRef = _firestore.doc(cartItemPath(userId, cartItemId));
    await itemRef.delete();
  }

  // Clear all items in the user's cart
  Future<void> clearUserCart(String userId) async {
    final cartItemsRef = _firestore.collection(cartPath(userId));
    final cartItemsSnapshot = await cartItemsRef.get();
    for (var doc in cartItemsSnapshot.docs) {
      await doc.reference.delete();
    }
  }

  // Watch user's cart as a stream
  Stream<List<CartItem>> watchUserCart(String userId) {
    return _firestore
        .collection(cartPath(userId))
        .withConverter<CartItem>(
          fromFirestore: (snapshot, _) =>
              CartItem.fromMap(snapshot.data()!, snapshot.id),
          toFirestore: (item, _) => item.toMap(),
        )
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // Fetch user's cart items as a list
  Future<List<CartItem>> fetchUserCart(String userId) async {
    final snapshot = await _firestore
        .collection(cartPath(userId))
        .withConverter<CartItem>(
          fromFirestore: (snapshot, _) =>
              CartItem.fromMap(snapshot.data()!, snapshot.id),
          toFirestore: (item, _) => item.toMap(),
        )
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}

@Riverpod(keepAlive: true)
CartRepository cartRepository(Ref ref) {
  return CartRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<CartItem>> userCartStream(Ref ref, String userId) {
  final repository = ref.watch(cartRepositoryProvider);
  return repository.watchUserCart(userId);
}

@riverpod
Future<List<CartItem>> userCartFuture(Ref ref, String userId) async {
  final repository = ref.watch(cartRepositoryProvider);
  return repository.fetchUserCart(userId);
}
