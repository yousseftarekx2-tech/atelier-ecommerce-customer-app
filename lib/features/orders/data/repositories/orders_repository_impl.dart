import '../../domain/entities/order.dart';
import '../../domain/entities/order_item.dart';
import '../../domain/repositories/orders_repository.dart';
import '../datasource/orders_remote_data_source.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  OrdersRepositoryImpl(this._remoteDataSource);

  final OrdersRemoteDataSource _remoteDataSource;

  @override
  Future<List<Order>> getOrders() async {
    final user = _remoteDataSource.currentUser;

    if (user == null) {
      return const [];
    }

    final data = await _remoteDataSource.getOrders(user.id);

    return data.map(_mapToEntity).toList();
  }

  @override
  Future<Order> createOrder(Order order) async {
    final user = _remoteDataSource.currentUser;

    if (user == null) {
      throw Exception('Please sign in before placing an order.');
    }

    final data = await _remoteDataSource.createOrder(
      order: order,
      userId: user.id,
    );

    return _mapToEntity(data);
  }

  @override
  Future<Order?> getOrderById(String id) async {
    final user = _remoteDataSource.currentUser;

    if (user == null) {
      return null;
    }

    final data = await _remoteDataSource.getOrderById(
      orderId: id,
      userId: user.id,
    );

    if (data == null) {
      return null;
    }

    return _mapToEntity(data);
  }

  Order _mapToEntity(Map<String, dynamic> data) {
    final rawItems = data['order_items'] as List<dynamic>? ?? const [];

    final items = rawItems
        .map(
          (item) => OrderItem(
            productId: item['product_id'] as String,
            productName: item['product_name'] as String,
            image: item['image'] as String,
            size: item['size'] as String,
            color: item['color'] as String,
            quantity: (item['quantity'] as num).toInt(),
            unitPrice: (item['unit_price'] as num).toInt(),
          ),
        )
        .toList();

    return Order(
      id: data['id'] as String,
      orderNumber: data['order_number'] as String,
      customerName: data['customer_name'] as String,
      customerEmail: data['customer_email'] as String,
      customerPhone: data['customer_phone'] as String,
      shippingAddress: OrderAddressSnapshot(
        fullName: data['shipping_full_name'] as String,
        phone: data['shipping_phone'] as String,
        label: data['shipping_label'] as String,
        street: data['shipping_street'] as String,
        city: data['shipping_city'] as String,
      ),
      shippingMethod: data['shipping_method'] as String,
      paymentMethod: data['payment_method'] as String,
      items: List.unmodifiable(items),
      subtotal: (data['subtotal'] as num).toInt(),
      shippingCost: (data['shipping_cost'] as num).toInt(),
      total: (data['total'] as num).toInt(),
      status: data['status'] as String,
      createdAt: DateTime.parse(data['created_at'] as String),
    );
  }
}
