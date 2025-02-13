import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_ecommerce/src/features/products/data/products_repository.dart';
import 'package:pro_ecommerce/src/features/products/domain/product.dart';

final productSearchControllerProvider =
    StateNotifierProvider<ProductSearchController, AsyncValue<List<Product>>>(
  (ref) => ProductSearchController(ref.read(productsRepositoryProvider)),
);

class ProductSearchController extends StateNotifier<AsyncValue<List<Product>>> {
  final ProductsRepository _repository;

  ProductSearchController(this._repository) : super(const AsyncValue.data([]));

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    state = const AsyncValue.loading();
    try {
      final results = await _repository.searchProductsByName(query);
      state = AsyncValue.data(results);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
