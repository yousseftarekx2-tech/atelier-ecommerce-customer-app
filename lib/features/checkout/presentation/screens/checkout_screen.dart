import 'package:atelier_customer/features/address/presentation/widgets/checkout_address_section.dart';
import 'package:atelier_customer/features/checkout/presentation/widgets/checkout_contact_section.dart';
import 'package:atelier_customer/features/checkout/presentation/widgets/checkout_order_summary.dart';
import 'package:atelier_customer/features/checkout/presentation/widgets/checkout_payment_section.dart';
import 'package:atelier_customer/features/checkout/presentation/widgets/checkout_place_order_button.dart';
import 'package:atelier_customer/features/shipping/cubit/shipping_cubit.dart';
import 'package:atelier_customer/features/shipping/presentation/widgets/checkout_shipping_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/cubit/auth_cubit.dart';
import '../../../cart/cubit/cart_cubit.dart';
import '../../../cart/cubit/cart_state.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;

    String? fullName;
    String? email;

    if (authState is AuthAuthenticated) {
      fullName = authState.user.fullName;
      email = authState.user.email;
    }

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
            ),
            title: const Text('Checkout'),
            centerTitle: true,
          ),
          body: state.items.isEmpty
              ? const Center(child: Text('Your bag is empty'))
              : BlocProvider(
                  create: (_) => ShippingCubit(subtotal: state.totalPrice),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Complete your order',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${state.itemCount} item${state.itemCount == 1 ? '' : 's'} in your bag',
                        ),
                        const SizedBox(height: 28),
                        CheckoutContactSection(
                          fullName: fullName,
                          email: email,
                        ),
                        const SizedBox(height: 24),
                        const CheckoutAddressSection(),
                        const SizedBox(height: 24),
                        const CheckoutShippingSection(),
                        const SizedBox(height: 24),
                        const CheckoutPaymentSection(),
                        const SizedBox(height: 24),
                        const CheckoutOrderSummary(),
                        const SizedBox(height: 24),
                        const CheckoutPlaceOrderButton(),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
