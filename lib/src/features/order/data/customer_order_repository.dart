import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pro_ecommerce/src/features/order/domain/customer_order.dart';

part 'customer_order_repository.g.dart';

class CustomerOrderRepository {
  final FirebaseFirestore _firestore;

  CustomerOrderRepository(this._firestore);

  static String orderPath(String orderId) => 'orders/$orderId';
  static String ordersPath() => 'orders';

  // Create
  Future<void> addOrder(CustomerOrder order) async {
    await _firestore.collection(ordersPath()).doc(order.id).set(order.toMap());
  }

  // Update
  Future<void> updateOrder(CustomerOrder order) async {
    await _firestore
        .collection(ordersPath())
        .doc(order.id)
        .update(order.toMap());
  }

  // Delete
  Future<void> deleteOrder(String orderId) async {
    await _firestore.collection(ordersPath()).doc(orderId).delete();
  }

  // Get
  Future<CustomerOrder> getOrder(String orderId) async {
    final doc = await _firestore.collection(ordersPath()).doc(orderId).get();
    if (doc.exists) {
      return CustomerOrder.fromMap(doc.data()!, doc.id);
    } else {
      throw Exception('Order not found');
    }
  }

  // Watch: Single Order
  Stream<CustomerOrder> watchOrder(String orderId) {
    return _firestore.collection(ordersPath()).doc(orderId).snapshots().map(
      (snapshot) {
        if (snapshot.exists) {
          return CustomerOrder.fromMap(snapshot.data()!, snapshot.id);
        } else {
          throw Exception('Order not found');
        }
      },
    );
  }

  // Watch: All Orders by User ID
  Stream<List<CustomerOrder>> watchOrders(String userId) {
    return _firestore
        .collection(ordersPath())
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => CustomerOrder.fromMap(doc.data()!, doc.id))
          .toList();
    });
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    await _firestore.collection(ordersPath()).doc(orderId).update({
      'status': status,
    });
  }
}

@riverpod
CustomerOrderRepository customerOrderRepository(Ref ref) {
  return CustomerOrderRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<CustomerOrder> customerOrderStream(Ref ref, String orderId) {
  final repository = ref.watch(customerOrderRepositoryProvider);
  return repository.watchOrder(orderId);
}

@riverpod
Stream<List<CustomerOrder>> customerOrdersStream(Ref ref, String userId) {
  final repository = ref.watch(customerOrderRepositoryProvider);
  return repository.watchOrders(userId);
}
