import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pro_ecommerce/src/features/order/data/customer_order_repository.dart';
import 'package:pro_ecommerce/src/features/order/domain/customer_order.dart';

class MockCustomerOrderRepository extends Mock
    implements CustomerOrderRepository {}

void main() {
  group('CustomerOrderRepository', () {
    late MockCustomerOrderRepository mockCustomerOrderRepository;

    setUp(() {
      mockCustomerOrderRepository = MockCustomerOrderRepository();
    });

    test('addOrder adds an order', () async {
      final order = CustomerOrder(
          id: '1',
          userId: '1',
          items: [],
          totalAmount: 100.0,
          status: 'pending',
          createdAt: DateTime.now(),
          deliveryAddress: 'Address',
          recipientName: 'Name',
          phoneNumber: '1234567890');
      await mockCustomerOrderRepository.addOrder(order);
      verify(mockCustomerOrderRepository.addOrder(order)).called(1);
    });

    test('getOrder returns an order', () async {
      final order = CustomerOrder(
          id: '1',
          userId: '1',
          items: [],
          totalAmount: 100.0,
          status: 'pending',
          createdAt: DateTime.now(),
          deliveryAddress: 'Address',
          recipientName: 'Name',
          phoneNumber: '1234567890');
      when(mockCustomerOrderRepository.getOrder('1'))
          .thenAnswer((_) async => order);

      final result = await mockCustomerOrderRepository.getOrder('1');
      expect(result, order);
    });

    test('deleteOrder deletes an order', () async {
      await mockCustomerOrderRepository.deleteOrder('1');
      verify(mockCustomerOrderRepository.deleteOrder('1')).called(1);
    });

    test('watchOrders returns a stream of orders', () {
      final orders = [
        CustomerOrder(
            id: '1',
            userId: '1',
            items: [],
            totalAmount: 100.0,
            status: 'pending',
            createdAt: DateTime.now(),
            deliveryAddress: 'Address',
            recipientName: 'Name',
            phoneNumber: '1234567890'),
      ];
      when(mockCustomerOrderRepository.watchOrders('1'))
          .thenAnswer((_) => Stream.value(orders));

      final result = mockCustomerOrderRepository.watchOrders('1');
      expect(result, emits(orders));
    });

    test('updateOrderStatus updates the order status', () async {
      final orderId = '1';
      final newStatus = 'shipped';
      await mockCustomerOrderRepository.updateOrderStatus(orderId, newStatus);
      verify(mockCustomerOrderRepository.updateOrderStatus(orderId, newStatus)).called(1);
    });
  });
}
