import 'package:atelier_customer/features/orders/cubit/oeder_cubit.dart';
import 'package:atelier_customer/features/orders/cubit/order_state.dart';
import 'package:atelier_customer/features/products/data/repositories/product_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../address/cubit/address_cubit.dart';
import '../../../auth/cubit/auth_cubit.dart';
import '../../../cart/cubit/cart_cubit.dart';
import '../../../orders/domain/entities/order.dart';
import '../../../orders/domain/entities/order_item.dart';
import '../../../shipping/cubit/shipping_cubit.dart';

class CheckoutPlaceOrderButton extends StatelessWidget {
  const CheckoutPlaceOrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrdersCubit, OrdersState>(
      listener: (context, state) {
        if (state is OrderCreated) {
          context.read<CartCubit>().clear();

          context.go('/order-confirmation');
        }

        if (state is OrdersError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, orderState) {
            final isCreating = orderState is OrderCreating;

            return ElevatedButton(
              onPressed: isCreating
                  ? null
                  : () {
                      _placeOrder(context);
                    },
              child: isCreating
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text(
                      'Place Order',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }

  void _placeOrder(BuildContext context) {
    final authState = context.read<AuthCubit>().state;
    final cartState = context.read<CartCubit>().state;
    final addressState = context.read<AddressCubit>().state;
    final shippingState = context.read<ShippingCubit>().state;

    if (authState is! AuthAuthenticated) {
      _showMessage(context, 'Please sign in before placing your order');
      return;
    }

    final address = addressState.selectedAddress;

    if (address == null) {
      _showMessage(context, 'Please select a shipping address');
      return;
    }

    if (cartState.items.isEmpty) {
      _showMessage(context, 'Your bag is empty');
      return;
    }

    final customerName = authState.user.fullName;

    if (customerName == null || customerName.trim().isEmpty) {
      _showMessage(context, 'Please complete your profile information');
      return;
    }

    final productRepository = ProductRepositoryImpl();

    final items = cartState.items.map((item) {
      final product = productRepository.getProductById(item.productId);

      if (product == null) {
        throw Exception('Product not found: ${item.productId}');
      }

      return OrderItem(
        productId: item.productId,
        productName: product.name,
        image: product.image,
        size: item.size,
        color: item.color,
        quantity: item.quantity,
        unitPrice: item.unitPrice,
      );
    }).toList();

    final shippingAddress = OrderAddressSnapshot(
      fullName: address.fullName,
      phone: address.phone,
      label: address.label,
      street: address.street,
      city: address.city,
    );

    context.read<OrdersCubit>().createOrder(
      customerName: customerName,
      customerEmail: authState.user.email,
      customerPhone: address.phone,
      shippingAddress: shippingAddress,
      shippingMethod: shippingState.selectedMethod.name,
      paymentMethod: 'Cash on Delivery',
      items: items,
      subtotal: cartState.totalPrice,
      shippingCost: shippingState.shippingCost,
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
