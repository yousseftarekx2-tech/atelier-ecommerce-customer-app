import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/entities/order.dart';
import '../domain/entities/order_item.dart';
import '../domain/repositories/orders_repository.dart';
import 'order_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this._ordersRepository) : super(const OrdersInitial());

  final OrdersRepository _ordersRepository;

  Order? _currentOrder;

  Order? get currentOrder => _currentOrder;

  List<Order> get orders => state.orders;

  Future<void> loadOrders() async {
    try {
      final orders = await _ordersRepository.getOrders();

      _currentOrder = orders.isNotEmpty ? orders.first : null;

      emit(OrdersLoaded(orders: List.unmodifiable(orders)));
    } catch (error) {
      emit(OrdersError(message: _mapError(error), orders: state.orders));
    }
  }

  Future<void> createOrder({
    required String customerName,
    required String customerEmail,
    required String customerPhone,
    required OrderAddressSnapshot shippingAddress,
    required String shippingMethod,
    required String paymentMethod,
    required List<OrderItem> items,
    required int subtotal,
    required int shippingCost,
  }) async {
    emit(OrderCreating(orders: state.orders));

    try {
      final order = Order(
        id: '',
        orderNumber: '#AT-${DateTime.now().millisecondsSinceEpoch}',
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

      final createdOrder = await _ordersRepository.createOrder(order);

      _currentOrder = createdOrder;

      final updatedOrders = [createdOrder, ...state.orders];

      emit(
        OrderCreated(
          order: createdOrder,
          orders: List.unmodifiable(updatedOrders),
        ),
      );
    } catch (error) {
      emit(OrdersError(message: _mapError(error), orders: state.orders));
    }
  }

  Future<Order?> getOrderById(String id) async {
    final existingOrder = state.orders.where((order) => order.id == id);

    if (existingOrder.isNotEmpty) {
      return existingOrder.first;
    }

    try {
      return await _ordersRepository.getOrderById(id);
    } catch (_) {
      return null;
    }
  }

  String _mapError(Object error) {
    final message = error.toString();

    if (message.contains('Authentication required')) {
      return 'Please sign in before placing your order.';
    }

    if (message.contains('network') ||
        message.contains('SocketException') ||
        message.contains('Failed host lookup')) {
      return 'Network error. Please check your connection.';
    }

    return message;
  }
}
