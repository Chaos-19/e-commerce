import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_ecommerce/src/common_widgets/shared_scaffold.dart';
import 'package:pro_ecommerce/src/features/products/domain/product.dart';
import 'package:pro_ecommerce/src/features/products/data/products_repository.dart';
import 'package:pro_ecommerce/src/features/cart/presenter/cart/cart_screen_controller.dart';
import 'package:pro_ecommerce/src/features/authentication/data/firebase_auth_repository.dart';

class ProductDetailScreen extends ConsumerWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsyncValue = ref.watch(productStreamProvider(productId));

    return SharedScaffold(
      title: 'Product Details',
      body: Column(
        children: [
          //_buildSearchBar(),
          // _buildBanner(context),
          Expanded(
            child: productAsyncValue.when(
              data: (product) => _buildProductDetail(context, ref, product),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetail(
      BuildContext context, WidgetRef ref, Product product) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: product.productImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Image.network(
                      product.productImages[index].url,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${product.price.toStringAsFixed(2)} ETB',
              style: const TextStyle(fontSize: 20, color: Colors.orange),
            ),
            const SizedBox(height: 8),
            Text(product.description),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final user = ref.read(authRepositoryProvider).currentUser;

                print('\n\n\nUser ID: ${user?.uid} \n\n\n\n');

                if (user == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('Please log in to add items to the cart.')),
                  );
                  return;
                }

                final userId = user.uid;
                try {
                  await ref
                      .read(cartScreenControllerProvider.notifier)
                      .addToCart(
                        userId: userId,
                        productId: product.id,
                        quantity: 1,
                      );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Product added to cart.')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Failed to add product to cart: $e')),
                  );
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Product added to cart.')),
                );
              },
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
