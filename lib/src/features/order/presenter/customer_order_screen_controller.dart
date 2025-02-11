import 'package:flutter/material.dart';
import 'package:pro_ecommerce/src/features/cart/domain/cart_item.dart';
import 'package:pro_ecommerce/src/features/order/data/customer_order_repository.dart';
import 'package:pro_ecommerce/src/features/order/domain/customer_order.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'customer_order_screen_controller.g.dart';

@riverpod
class CustomerOrderScreenController extends _$CustomerOrderScreenController {
  late final CustomerOrderRepository _orderRepository;

  @override
  FutureOr<void> build() {
    _orderRepository = ref.read(customerOrderRepositoryProvider);
  }

  Future<void> placeOrder({
    required String userId,
    required List<OrderItem> items,
    required double totalAmount,
    required String deliveryAddress,
    required String recipientName,
    required String phoneNumber,
  }) async {
    final order = CustomerOrder(
      id: UniqueKey().toString(),
      userId: userId,
      items: items,
      totalAmount: totalAmount,
      status: 'Pending',
      createdAt: DateTime.now(),
      deliveryAddress: deliveryAddress,
      recipientName: recipientName,
      phoneNumber: phoneNumber,
    );

    await _orderRepository.addOrder(order);
  }

  /// Fetch the user's orders as a stream
  Stream<List<CustomerOrder>> watchOrders(String userId) {
    return _orderRepository.watchOrders(userId);
  }

  /// Update the order status
  Future<void> updateOrderStatus({
    required String orderId,
    required String newStatus,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _orderRepository.updateOrderStatus(orderId, newStatus);
    });
  }

  /// Cancel an order
  Future<void> cancelOrder(String orderId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _orderRepository.deleteOrder(orderId);
    });
  }
}
