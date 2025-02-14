import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_ecommerce/src/common_widgets/product_card.dart';

import 'package:pro_ecommerce/src/common_widgets/shared_scaffold.dart';
import 'package:pro_ecommerce/src/constants/strings.dart';
import 'package:pro_ecommerce/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:pro_ecommerce/src/features/products/data/products_repository.dart';
import 'package:pro_ecommerce/src/features/products/domain/product.dart';

import 'package:pro_ecommerce/src/features/products/presentation/products_screen/products_screen_controller.dart';
import 'package:pro_ecommerce/src/features/wishlist/data/wishlist_repository.dart';
import 'package:pro_ecommerce/src/routing/app_router.dart';

import 'package:pro_ecommerce/src/utils/async_value_ui.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SharedScaffold(
      title: Strings.ecommerce,
      body: Column(
        children: [
          //_buildSearchBar(),
          // _buildBanner(context),
          Expanded(child: _buildProductList(context)),
        ],
      ),
    );
  }

  Widget _buildBanner(BuildContext context) {
    final List<String> imgList = [
      'https://via.placeholder.com/600x200.png?text=Offer+1',
      'https://via.placeholder.com/600x200.png?text=Offer+2',
      'https://via.placeholder.com/600x200.png?text=Offer+3',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 150.0,
        autoPlay: true,
        padEnds: true,
        aspectRatio: 2.0,
      ),
      items: imgList
          .map((item) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                          colors: [Color(0xff53E88B), Color(0xff15BE77)])),
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: .5,
                        child: Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/BACKGROUND%202.png?alt=media&token=0d003860-ba2f-4782-a5ee-5d5684cdc244",
                            fit: BoxFit.cover),
                      ),
                      Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/Image.png?alt=media&token=8256c357-cf86-4f76-8c4d-4322d1ebc06c"),
                      const Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.all(25.0),
                          child: Text(
                            "Want some\nicecream?",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        //controller: new ,
        onChanged: (value) {
          //Do something wi
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xff4338CA),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: "Search",
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
      ),
    );
  }

  Widget _buildProductList(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final productsQuery = ref.watch(productsQueryProvider);

        return FirestoreQueryBuilder<Product>(
          query: productsQuery,
          builder: (context, snapshot, _) {
            if (snapshot.isFetching && snapshot.docs.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.docs.isEmpty) {
              return const Center(child: Text('No products found'));
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75,
              ),
              itemCount: snapshot.docs.length + (snapshot.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                // If the user scrolls to the last item, fetch more data
                if (index == snapshot.docs.length) {
                  snapshot.fetchMore(); // Fetch the next batch
                  return const Center(child: CircularProgressIndicator());
                }

                final doc = snapshot.docs[index];
                final product = doc.data();

                return ProductCard(
                  productId: product.id,
                  name: product.name,
                  price: product.price,
                  oldPrice: product.price,
                  stock: product.stock,
                  rating: product.stock.toDouble(),
                  imageUrl: product.productImages.first.url,
                  onTap: () {
                    try {
                      context.goNamed(
                        AppRoute.productDetail.name,
                        pathParameters: {'id': product.id},
                      );
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
