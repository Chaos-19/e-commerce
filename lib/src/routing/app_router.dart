import 'package:flutter/material.dart';
import 'package:pro_ecommerce/src/features/cart/presenter/cart/cart_screen.dart';
import 'package:pro_ecommerce/src/features/category/presenter/category_screen/category_screen.dart';
import 'package:pro_ecommerce/src/features/order/presenter/customer_order_screen.dart';
import 'package:pro_ecommerce/src/features/products/presentation/products_screen/products_screen.dart';
import 'package:pro_ecommerce/src/features/products/presentation/product_details_screen/product_details_screen.dart';
import 'package:pro_ecommerce/src/features/wishlist/presenter/wishlist_screen.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pro_ecommerce/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:pro_ecommerce/src/features/authentication/presentation/custom_profile_screen.dart';
import 'package:pro_ecommerce/src/features/authentication/presentation/custom_sign_in_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_ecommerce/src/features/onboarding/data/onboarding_repository.dart';
import 'package:pro_ecommerce/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:pro_ecommerce/src/routing/go_router_refresh_stream.dart';
import 'package:pro_ecommerce/src/routing/not_found_screen.dart';
import 'package:pro_ecommerce/src/routing/scaffold_with_nested_navigation.dart';

part 'app_router.g.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _productsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'products');
//final _entriesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'entries');
final _cartNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'cart');
//final _customerOrderNavigatorKey =
//    GlobalKey<NavigatorState>(debugLabel: 'customerOrder');
final _wishlistNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'wishlist');
final _categoryNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'category');
final _accountNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'account');

enum AppRoute {
  onboarding,
  signIn,
  products,
  cart,
  wishlist,
  category,
  customerOrder,
  // addJob,
  // editJob,
  // entry,
  // addEntry,
  // editEntry,
  // entries,

  profile,
  productDetail
}

@riverpod
GoRouter goRouter(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/signIn',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final onboardingRepository =
          ref.read(onboardingRepositoryProvider).requireValue;
      final didCompleteOnboarding = onboardingRepository.isOnboardingComplete();
      final path = state.uri.path;
      if (!didCompleteOnboarding) {
        // Always check state.subloc before returning a non-null route
        // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/redirection.dart#L78
        if (path != '/onboarding') {
          return '/onboarding';
        }
        return null;
      }
      final isLoggedIn = authRepository.currentUser != null;
      if (isLoggedIn) {
        if (path.startsWith('/onboarding') || path.startsWith('/signIn')) {
          return '/products';
        }
      } else {
        if (path.startsWith('/onboarding') ||
            path.startsWith('/products') ||
            path.startsWith('/wishlist') ||
            path.startsWith('/category') ||
            path.startsWith('/customerOrder') ||
            path.startsWith('/cart') ||
            path.startsWith('/account')) {
          return '/signIn';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/onboarding',
        name: AppRoute.onboarding.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: '/signIn',
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: CustomSignInScreen(),
        ),
      ),

      GoRoute(
        path: '/customerOrder',
        name: AppRoute.customerOrder.name,
        parentNavigatorKey:
            _rootNavigatorKey, // Ensures it's pushed above the bottom nav
        pageBuilder: (context, state) => NoTransitionPage(
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Customer Order"),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.go('/products');
                },
              ),
            ),
            body: const CustomerOrderScreen(),
          ),
        ),
      ),

      // Stateful navigation based on:
      // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) => NoTransitionPage(
          child: ScaffoldWithNestedNavigation(navigationShell: navigationShell),
        ),
        branches: [
          StatefulShellBranch(
            navigatorKey: _productsNavigatorKey,
            routes: [
              GoRoute(
                path: '/products',
                name: AppRoute.products.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ProductScreen(),
                ),
                routes: [
                  GoRoute(
                    path: ':id',
                    name: AppRoute.productDetail.name,
                    pageBuilder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return NoTransitionPage(
                        child: ProductDetailScreen(
                          productId: id,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _wishlistNavigatorKey,
            routes: [
              GoRoute(
                path: '/wishlist',
                name: AppRoute.wishlist.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: WishlistScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _categoryNavigatorKey,
            routes: [
              GoRoute(
                path: '/category',
                name: AppRoute.category.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CategoryScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _cartNavigatorKey,
            routes: [
              GoRoute(
                path: '/cart',
                name: AppRoute.cart.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CartScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _accountNavigatorKey,
            routes: [
              GoRoute(
                path: '/account',
                name: AppRoute.profile.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CustomProfileScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) => const NoTransitionPage(
      child: NotFoundScreen(),
    ),
  );
}
