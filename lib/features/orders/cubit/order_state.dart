import 'package:equatable/equatable.dart';

import '../domain/entities/order.dart';

sealed class OrdersState extends Equatable {
  const OrdersState({this.orders = const []});

  final List<Order> orders;

  @override
  List<Object?> get props => [orders];
}

final class OrdersInitial extends OrdersState {
  const OrdersInitial();
}

final class OrderCreating extends OrdersState {
  const OrderCreating({super.orders});
}

final class OrderCreated extends OrdersState {
  const OrderCreated({required this.order, super.orders});

  final Order order;

  @override
  List<Object?> get props => [orders, order];
}

final class OrdersLoaded extends OrdersState {
  const OrdersLoaded({required super.orders});
}

final class OrdersError extends OrdersState {
  const OrdersError({required this.message, super.orders});

  final String message;

  @override
  List<Object?> get props => [orders, message];
}
