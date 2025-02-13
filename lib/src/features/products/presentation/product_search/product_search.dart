import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_ecommerce/src/common_widgets/product_card.dart';
import 'package:pro_ecommerce/src/features/products/domain/product.dart';
import 'package:pro_ecommerce/src/features/products/presentation/product_search/prodcut_search_screen_controller.dart';
import 'package:pro_ecommerce/src/routing/app_router.dart';

class ProductSearchScreen extends ConsumerStatefulWidget {
  const ProductSearchScreen({super.key});

  @override
  ConsumerState<ProductSearchScreen> createState() =>
      _ProductSearchScreenState();
}

class _ProductSearchScreenState extends ConsumerState<ProductSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  void _onSearch() {
    final query = _searchController.text.trim();
    ref.read(productSearchControllerProvider.notifier).searchProducts(query);
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(productSearchControllerProvider);

    return Scaffold(
      appBar: AppBar(
          title: const Text('Search Products'),
          leading: IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            //onPressed: () {},
            onPressed: () => context.goNamed(AppRoute.products.name),
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (_) => _onSearch(),
            ),
          ),
          Expanded(
            child: searchResults.when(
              data: (products) => products.isEmpty
                  ? const Center(child: Text('No products found'))
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 8.0, // Space between columns
                        mainAxisSpacing: 8.0, // Space between rows
                        childAspectRatio: 0.75, // Aspect ratio of each item
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductCard(
                          name: product.name,
                          price: product.price,
                          oldPrice: product.price,
                          stock: product.stock,
                          rating: product.stock.toDouble(),
                          imageUrl: product.productImages.first.url,
                          productId: product.id,
                          onTap: () => {},
                        );
                      },
                    ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
