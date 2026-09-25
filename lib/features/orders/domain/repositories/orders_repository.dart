import '../entities/order.dart';

abstract class OrdersRepository {
  Future<List<Order>> getOrders();

  Future<Order> createOrder(Order order);

  Future<Order?> getOrderById(String id);
}