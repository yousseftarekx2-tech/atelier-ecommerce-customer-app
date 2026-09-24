import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/shipping_cubit.dart';
import '../../cubit/shipping_state.dart';
import '../../domain/entities/shipping_method.dart';

class CheckoutShippingSection extends StatelessWidget {
  const CheckoutShippingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShippingCubit, ShippingState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '03  SHIPPING METHOD',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            ...ShippingMethod.availableMethods.map((method) {
              final isSelected = method.id == state.selectedMethod.id;

              final price = method.id == ShippingMethod.standard.id
                  ? state.subtotal >= 5000
                        ? 0
                        : 80
                  : 150;

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () {
                    context.read<ShippingCubit>().selectMethod(method);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected
                            ? Colors.black
                            : const Color(0xFFE6E4E0),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                method.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                method.description,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF777777),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          price == 0 ? 'Free' : 'EGP $price',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
