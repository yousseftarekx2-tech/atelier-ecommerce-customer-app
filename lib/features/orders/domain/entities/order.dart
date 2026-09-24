import 'order_item.dart';

class Order {
  const Order({
    required this.id,
    required this.orderNumber,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.shippingAddress,
    required this.shippingMethod,
    required this.paymentMethod,
    required this.items,
    required this.subtotal,
    required this.shippingCost,
    required this.total,
    required this.status,
    required this.createdAt,
  });

  final String id;
  final String orderNumber;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final OrderAddressSnapshot shippingAddress;
  final String shippingMethod;
  final String paymentMethod;
  final List<OrderItem> items;
  final int subtotal;
  final int shippingCost;
  final int total;
  final String status;
  final DateTime createdAt;
}

class OrderAddressSnapshot {
  const OrderAddressSnapshot({
    required this.fullName,
    required this.phone,
    required this.label,
    required this.street,
    required this.city,
  });

  final String fullName;
  final String phone;
  final String label;
  final String street;
  final String city;
}
