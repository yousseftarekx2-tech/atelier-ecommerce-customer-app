import 'package:atelier_customer/core/routing/routes.dart';
import 'package:atelier_customer/features/orders/cubit/oeder_cubit.dart';
import 'package:atelier_customer/features/orders/cubit/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OrdersCubit>().state;

    if (state is! OrderCreated) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Order Confirmation'),
          centerTitle: true,
        ),
        body: const Center(child: Text('No order found')),
      );
    }

    final order = state.order;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Order Confirmation'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 36),
            ),
            const SizedBox(height: 24),
            const Text(
              'Order Placed Successfully',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            const Text(
              'Thank you for your order. We’ll start preparing it shortly.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF777777),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE6E4E0)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _InfoRow(label: 'Order Number', value: order.orderNumber),
                  const SizedBox(height: 16),
                  _InfoRow(label: 'Items', value: '${order.items.length}'),
                  const SizedBox(height: 16),
                  _InfoRow(label: 'Payment', value: order.paymentMethod),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    child: Divider(height: 1),
                  ),
                  _InfoRow(
                    label: 'Total',
                    value: 'EGP ${order.total}',
                    isTotal: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F6F3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.local_shipping_outlined, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.shippingMethod,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${order.shippingAddress.street}, '
                          '${order.shippingAddress.city}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  context.push(Routes.orderDetailsPath(order.id));
                },
                child: const Text(
                  'View Order',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: OutlinedButton(
                onPressed: () {
                  context.go(Routes.home);
                },
                child: const Text(
                  'Continue Shopping',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 15 : 13,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              color: isTotal ? Colors.black : const Color(0xFF777777),
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 17 : 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
