import 'package:atelier_customer/features/shipping/cubit/shipping_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/cubit/cart_cubit.dart';
import '../../../cart/cubit/cart_state.dart';
import '../../../shipping/cubit/shipping_state.dart';

class CheckoutOrderSummary extends StatelessWidget {
  const CheckoutOrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, cartState) {
        return BlocBuilder<ShippingCubit, ShippingState>(
          builder: (context, shippingState) {
            final subtotal = cartState.totalPrice;
            final shippingCost = shippingState.shippingCost;
            final total = subtotal + shippingCost;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '05  ORDER SUMMARY',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE6E4E0)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _SummaryRow(label: 'Subtotal', value: 'EGP $subtotal'),
                      const SizedBox(height: 12),
                      _SummaryRow(
                        label: shippingState.selectedMethod.name,
                        value: shippingCost == 0 ? 'Free' : 'EGP $shippingCost',
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Divider(height: 1),
                      ),
                      _SummaryRow(
                        label: 'Total',
                        value: 'EGP $total',
                        isTotal: true,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
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
            fontSize: isTotal ? 16 : 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
