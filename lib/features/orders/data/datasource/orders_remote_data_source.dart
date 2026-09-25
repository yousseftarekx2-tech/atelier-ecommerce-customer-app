import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/order.dart';

class OrdersRemoteDataSource {
  OrdersRemoteDataSource(this._supabase);

  final SupabaseClient _supabase;

  User? get currentUser => _supabase.auth.currentUser;

  Future<List<Map<String, dynamic>>> getOrders(String userId) async {
    final response = await _supabase
        .from('orders')
        .select('*, order_items(*)')
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<Map<String, dynamic>> createOrder({
    required Order order,
    required String userId,
  }) async {
    final payload = {
      'order_number': order.orderNumber,
      'customer_name': order.customerName,
      'customer_email': order.customerEmail,
      'customer_phone': order.customerPhone,
      'shipping_address': {
        'full_name': order.shippingAddress.fullName,
        'phone': order.shippingAddress.phone,
        'label': order.shippingAddress.label,
        'street': order.shippingAddress.street,
        'city': order.shippingAddress.city,
      },
      'shipping_method': order.shippingMethod,
      'payment_method': order.paymentMethod,
      'subtotal': order.subtotal,
      'shipping_cost': order.shippingCost,
      'total': order.total,
      'status': order.status,
      'items': order.items
          .map(
            (item) => {
              'product_id': item.productId,
              'product_name': item.productName,
              'image': item.image,
              'size': item.size,
              'color': item.color,
              'quantity': item.quantity,
              'unit_price': item.unitPrice,
            },
          )
          .toList(),
    };

    final createdOrderId = await _supabase.rpc(
      'create_order',
      params: {'payload': payload},
    );

    final response = await _supabase
        .from('orders')
        .select('*, order_items(*)')
        .eq('id', createdOrderId)
        .eq('user_id', userId)
        .single();

    return Map<String, dynamic>.from(response);
  }

  Future<Map<String, dynamic>?> getOrderById({
    required String orderId,
    required String userId,
  }) async {
    final response = await _supabase
        .from('orders')
        .select('*, order_items(*)')
        .eq('id', orderId)
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return Map<String, dynamic>.from(response);
  }
}
