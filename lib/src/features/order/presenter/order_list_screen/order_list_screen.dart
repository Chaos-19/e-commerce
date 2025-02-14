import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_ecommerce/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:pro_ecommerce/src/features/order/data/customer_order_repository.dart';
import 'package:pro_ecommerce/src/features/order/domain/customer_order.dart';
import 'package:pro_ecommerce/src/features/order/presenter/customer_order_screen/customer_order_screen_controller.dart';

class OrderListScreen extends ConsumerWidget {
  const OrderListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authRepositoryProvider).currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Orders'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: const Center(child: Text('Please log in to view your orders.')),
      );
    }

    final ordersStream = ref.watch(customerOrdersStreamProvider(user.uid));

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ordersStream.when(
        data: (orders) => ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return ListTile(
              title: Text('Order #${order.id}'),
              subtitle: Text('Status: ${order.status}'),
              trailing: order.status == 'Pending'
                  ? IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () async {
                        await ref
                            .read(
                                customerOrderScreenControllerProvider.notifier)
                            .cancelOrder(order.id);
                      },
                    )
                  : null,
              onTap: () {
                // Navigate to order details if needed
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
