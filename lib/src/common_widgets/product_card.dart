import 'package:flutter/material.dart';
/*
class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double price;
  final double oldPrice;
  final int stock;
  final double rating;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.stock,
    required this.rating,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              // Product Name
              Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              // Price Section
              Row(
                children: [
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (oldPrice > price)
                    Text(
                      '\$${oldPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              // Stock Info
              Text(
                stock > 0 ? '$stock left' : 'Sold Out',
                style: TextStyle(
                  color: stock > 0 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              // Rating
              Row(
                children: [
                  Icon(Icons.star, size: 16, color: Colors.orange),
                  const SizedBox(width: 4),
                  Text(
                    rating.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final double price;
  final double oldPrice;
  final int stock;
  final double rating;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.stock,
    required this.rating,
    required this.onTap,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isWishlisted = false;

  void toggleWishlist() {
    setState(() {
      isWishlisted = !isWishlisted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      widget.imageUrl,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Product Name
                  Text(
                    widget.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Price Section
                  Row(
                    children: [
                      Text(
                        '\$${widget.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (widget.oldPrice > widget.price)
                        Text(
                          '\$${widget.oldPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Stock Info
                  Text(
                    widget.stock > 0 ? '${widget.stock} left' : 'Sold Out',
                    style: TextStyle(
                      color: widget.stock > 0 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        widget.rating.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Wishlist Button (Top Right)
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: toggleWishlist,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // ignore: deprecated_member_use
                    color: Colors.white.withOpacity(0.9),
                    boxShadow: [
                      BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.1), blurRadius: 3),
                    ],
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Icon(
                    isWishlisted ? Icons.favorite : Icons.favorite_border,
                    color: isWishlisted ? Colors.red : Colors.grey,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_ecommerce/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:pro_ecommerce/src/features/wishlist/data/wishlist_repository.dart';

class ProductCard extends ConsumerWidget {
  final String name;
  final double price;
  final double oldPrice;
  final int stock;
  final double rating;
  final String imageUrl;
  final String productId;
  final VoidCallback onTap;

  const ProductCard({
    Key? key,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.stock,
    required this.rating,
    required this.imageUrl,
    required this.productId,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authRepositoryProvider).currentUser;
    final wishlistAsyncValue =
        ref.watch(wishlistStreamProvider(user?.uid ?? ''));

    return wishlistAsyncValue.when(
      data: (wishlist) {
        final isWishlisted = wishlist.contains(productId);

        return GestureDetector(
          onTap: onTap,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 4,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          imageUrl,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Product Name
                      Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Price Section
                      Row(
                        children: [
                          Text(
                            '${price.toStringAsFixed(2)}ETB',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (oldPrice > price)
                            Text(
                              '\$${oldPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Stock Info
                      Text(
                        stock > 0 ? '${stock} left' : 'Sold Out',
                        style: TextStyle(
                          color: stock > 0 ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Rating
                      Row(
                        children: [
                          const Icon(Icons.star,
                              size: 16, color: Colors.orange),
                          const SizedBox(width: 4),
                          Text(
                            rating.toStringAsFixed(1),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Wishlist Button (Top Right)
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('ProductCard: onTap: isWishlisted: $isWishlisted');

                      for (var element in wishlist) {
                        print('ProductCard: onTap: wishlist: $element');
                      }

                      if (user == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Please log in to add items to the wishlist.'),
                          ),
                        );
                        return;
                      }

                      if (isWishlisted) {
                        ref.read(wishlistRepositoryProvider).removeWishlistItem(
                              userId: user.uid,
                              productId: productId,
                            );
                      } else {
                        ref.read(wishlistRepositoryProvider).addWishlistItem(
                              userId: user.uid,
                              productId: productId,
                            );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // ignore: deprecated_member_use
                        color: Colors.white.withOpacity(0.9),
                        boxShadow: [
                          BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 3),
                        ],
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Icon(
                        isWishlisted ? Icons.favorite : Icons.favorite_border,
                        color: isWishlisted ? Colors.red : Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
