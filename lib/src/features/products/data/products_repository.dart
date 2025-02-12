import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pro_ecommerce/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:pro_ecommerce/src/features/authentication/domain/app_user.dart';

import 'package:pro_ecommerce/src/features/products/domain/product.dart';

part 'products_repository.g.dart';

class ProductsRepository {
  const ProductsRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static String productPath(String productId) => 'products/$productId';
  static String productsPath() => 'products';

  // Create
  Future<void> addProduct({
    required String name,
    required String description,
    required double price,
    required int stock,
    required String sellerId,
    required String status,
    required List<String> categories,
    required List<String> tags,
    required List<String> images,
    required DateTime expiresOn,
    required Map<String, dynamic> metadata,
  }) async {
    final product = Product(
      id: _firestore.collection(productsPath()).doc().id,
      name: name,
      description: description,
      price: price,
      stock: stock,
      sellerId: sellerId,
      status: status,
      categories: categories,
      tags: tags,
      productImages: images
          .map((publicId) => ProductImage.fromPublicId(publicId))
          .toList(),
      //expiresOn: expiresOn,
      metadata: metadata,
    );
    await _firestore
        .collection(productsPath())
        .doc(product.id)
        .set(product.toMap());
  }

  // Update
  Future<void> updateProduct(Product product) async {
    await _firestore
        .collection(productsPath())
        .doc(product.id)
        .update(product.toMap());
  }

  // Delete
  Future<void> deleteProduct(
      {required String productId, required String uid}) async {
    try {
      final productRef = _firestore.doc(productPath(productId));
      await productRef.delete();
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }

  // Get
  Future<Product> getProduct(String productId) async {
    final doc =
        await _firestore.collection(productsPath()).doc(productId).get();
    if (doc.exists) {
      return Product.fromMap(doc.data()!, doc.id);
    } else {
      throw Exception('Product not found');
    }
  }

  // Read: Single Product
  Stream<Product> watchProduct({required String productId}) => _firestore
      .doc(productPath(productId))
      .withConverter<Product>(
        fromFirestore: (snapshot, _) =>
            Product.fromMap(snapshot.data()!, snapshot.id),
        toFirestore: (product, _) => product.toMap(),
      )
      .snapshots()
      .map((snapshot) => snapshot.data()!);

  // Read: All Products
  Stream<List<Product>> watchProducts() => queryProducts()
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  Query<Product> queryProducts() =>
      _firestore.collection(productsPath()).withConverter(
            fromFirestore: (snapshot, _) =>
                Product.fromMap(snapshot.data()!, snapshot.id),
            toFirestore: (product, _) => product.toMap(),
          );

  Future<List<Product>> fetchProducts() async {
    final products = await queryProducts().get();
    return products.docs.map((doc) => doc.data()).toList();
  }

  // Search by category
  Future<List<Product>> searchProductsByCategory(String category) async {
    final querySnapshot = await _firestore
        .collection(productsPath())
        .where('categories', arrayContains: category)
        .get();
    return querySnapshot.docs
        .map((doc) => Product.fromMap(doc.data(), doc.id))
        .toList();
  }
}

@Riverpod(keepAlive: true)
ProductsRepository productsRepository(Ref ref) {
  return ProductsRepository(FirebaseFirestore.instance);
}

@riverpod
Query<Product> productsQuery(Ref ref) {
  final repository = ref.watch(productsRepositoryProvider);
  return repository.queryProducts();
}

@riverpod
Stream<Product> productStream(Ref ref, String productId) {
  final repository = ref.watch(productsRepositoryProvider);
  return repository.watchProduct(productId: productId);
}
