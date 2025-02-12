import 'package:chapa_unofficial/chapa_unofficial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_ecommerce/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:pro_ecommerce/src/features/cart/data/cart_repository.dart';
import 'package:pro_ecommerce/src/features/order/data/customer_order_repository.dart';
import 'package:pro_ecommerce/src/features/order/domain/customer_order.dart';
import 'package:pro_ecommerce/src/features/order/presenter/customer_order_screen_controller.dart';
import 'package:pro_ecommerce/src/features/products/data/products_repository.dart';
import 'package:pro_ecommerce/src/routing/app_router.dart';

//import 'package:chapasdk/chapasdk.dart';

import 'package:chapa_unofficial/chapa_unofficial.dart';

class CustomerOrderScreen extends ConsumerStatefulWidget {
  const CustomerOrderScreen({super.key});

  @override
  ConsumerState<CustomerOrderScreen> createState() =>
      _CustomerOrderScreenState();
}

class _CustomerOrderScreenState extends ConsumerState<CustomerOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  final TextEditingController _deliveryAddressController =
      TextEditingController();
  final TextEditingController _recipientNameController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  List<OrderItem> orderItems = [];
  double totalAmount = 0;

  @override
  void dispose() {
    _deliveryAddressController.dispose();
    _recipientNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _fetchCartDetails(WidgetRef ref) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) return;

    final cartItems =
        await ref.read(cartRepositoryProvider).fetchUserCart(user.uid);
    double total = 0;
    List<OrderItem> items = [];

    for (var item in cartItems) {
      final product =
          await ref.read(productsRepositoryProvider).getProduct(item.productId);
      total += item.quantity * product.price;
      items.add(OrderItem(
        productId: item.productId,
        name: product.name,
        quantity: item.quantity,
        price: product.price,
        imageUrl: product.productImages.first.url,
      ));
    }

    setState(() {
      orderItems = items;
      totalAmount = total;
    });
  }

  Future<void> _clearCart(WidgetRef ref, String userId) async {
    await ref.read(cartRepositoryProvider).clearUserCart(userId);
  }

  void _submitOrder(BuildContext context, WidgetRef ref) async {
    if (!_formKey.currentState!.validate()) return;

    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to place an order.')),
      );
      return;
    }

    try {
      await ref.read(customerOrderScreenControllerProvider.notifier).placeOrder(
            userId: user.uid,
            items: orderItems,
            totalAmount: totalAmount,
            deliveryAddress: _deliveryAddressController.text,
            recipientName: _recipientNameController.text,
            phoneNumber: _phoneNumberController.text,
          );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order placed successfully!')),
      );

      setState(() {
        _currentStep += 1;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to place order: $e')),
      );
    }
  }

  Future<void> initiatePayment(double amount) async {
    Chapa.configure(
        privateKey: 'CHASECK_TEST-nfishiESuj9TlorDI8C9qedpY7kkTZpf');
    // Generate a random transaction reference with a custom prefix
    String txRef = TxRefRandomGenerator.generate(prefix: 'Pharmabet');

    // Access the generated transaction reference
    String storedTxRef = TxRefRandomGenerator.gettxRef;

    await Chapa.getInstance.startPayment(
      context: context,
      onInAppPaymentSuccess: (successMsg) async {
        // Clear the cart after placing the order
        String userId = ref.read(authRepositoryProvider).currentUser!.uid;
        await _clearCart(ref, userId);
        context.goNamed(AppRoute.cart.name);
      },
      onInAppPaymentError: (errorMsg) {
        print('Error: $errorMsg');
      },
      amount: '$amount',
      currency: 'ETB',
      txRef: storedTxRef,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return SizedBox(
          width: double.infinity,
          child: Stepper(
            type: StepperType.horizontal,
            currentStep: _currentStep,
            onStepContinue: () {
              if (_currentStep == 0) {
                if (_formKey.currentState!.validate()) {
                  _fetchCartDetails(ref);
                  setState(() {
                    _currentStep += 1;
                  });
                }
              } else if (_currentStep == 1) {
                _submitOrder(context, ref);
              } else if (_currentStep == 2) {
                initiatePayment(this.totalAmount);
              }
            },
            onStepCancel: () {
              if (_currentStep > 0) {
                setState(() {
                  _currentStep -= 1;
                });
              }
            },
            steps: [
              Step(
                title: const Text('Order Info'),
                isActive: _currentStep >= 0,
                state:
                    _currentStep > 0 ? StepState.complete : StepState.editing,
                content: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _recipientNameController,
                        decoration:
                            const InputDecoration(labelText: 'Recipient Name'),
                        validator: (value) =>
                            value!.isEmpty ? 'Enter recipient name' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _phoneNumberController,
                        decoration:
                            const InputDecoration(labelText: 'Phone Number'),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) return 'Enter phone number';
                          if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value)) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _deliveryAddressController,
                        decoration: const InputDecoration(
                            labelText: 'Delivery Address'),
                        validator: (value) =>
                            value!.isEmpty ? 'Enter delivery address' : null,
                      ),
                    ],
                  ),
                ),
              ),
              Step(
                title: const Text('Review Order'),
                isActive: _currentStep >= 1,
                state:
                    _currentStep > 1 ? StepState.complete : StepState.editing,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recipient: ${_recipientNameController.text}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Phone: ${_phoneNumberController.text}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Address: ${_deliveryAddressController.text}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    Text(
                      'Order Summary',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    for (var item in orderItems)
                      ListTile(
                        leading:
                            Image.network(item.imageUrl, width: 50, height: 50),
                        title: Text(item.name),
                        subtitle: Text(
                            '${item.quantity} x \$${item.price.toStringAsFixed(2)}'),
                        trailing: Text(
                            '\$${(item.quantity * item.price).toStringAsFixed(2)}'),
                      ),
                    const Divider(),
                    Text(
                      'Total: \$${totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Step(
                title: const Text('Payment'),
                isActive: _currentStep >= 2,
                state: StepState.editing,
                content: const Center(
                  child: Text(
                    'Proceed to payment screen.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
