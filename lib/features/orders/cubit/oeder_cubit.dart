import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/entities/order.dart';
import '../domain/entities/order_item.dart';
import 'order_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(const OrdersInitial());

  Order? _currentOrder;

  Order? get currentOrder => _currentOrder;

  List<Order> get orders => state.orders;

  void createOrder({
    required String customerName,
    required String customerEmail,
    required String customerPhone,
    required OrderAddressSnapshot shippingAddress,
    required String shippingMethod,
    required String paymentMethod,
    required List<OrderItem> items,
    required int subtotal,
    required int shippingCost,
  }) {
    emit(OrderCreating(orders: state.orders));

    final order = Order(
      id: 'order_${DateTime.now().millisecondsSinceEpoch}',
      orderNumber:
          '#AT-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      customerName: customerName,
      customerEmail: customerEmail,
      customerPhone: customerPhone,
      shippingAddress: shippingAddress,
      shippingMethod: shippingMethod,
      paymentMethod: paymentMethod,
      items: List.unmodifiable(items),
      subtotal: subtotal,
      shippingCost: shippingCost,
      total: subtotal + shippingCost,
      status: 'Placed',
      createdAt: DateTime.now(),
    );

    _currentOrder = order;

    final updatedOrders = [order, ...state.orders];

    emit(OrderCreated(order: order, orders: List.unmodifiable(updatedOrders)));
  }

  void loadOrders() {
    emit(OrdersLoaded(orders: state.orders));
  }

  Order? getOrderById(String id) {
    for (final order in state.orders) {
      if (order.id == id) {
        return order;
      }
    }

    return null;
  }
}
