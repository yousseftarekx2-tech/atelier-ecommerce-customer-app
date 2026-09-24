class OrderItem {
  const OrderItem({
    required this.productId,
    required this.productName,
    required this.image,
    required this.size,
    required this.color,
    required this.quantity,
    required this.unitPrice,
  });

  final String productId;
  final String productName;
  final String image;
  final String size;
  final String color;
  final int quantity;
  final int unitPrice;

  int get totalPrice => unitPrice * quantity;
}