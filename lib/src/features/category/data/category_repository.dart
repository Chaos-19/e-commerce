import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pro_ecommerce/src/features/category/domain/category.dart';

class CategoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Category>> fetchCategories() async {
    final querySnapshot = await _firestore.collection('products').get();
    final categories = querySnapshot.docs
        .map((doc) => Category.fromMap(doc.data(), doc.id))
        .toList();
    return categories;
  }
}