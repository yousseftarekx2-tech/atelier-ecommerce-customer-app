import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  const CartItem({
    required this.productId,
    required this.size,
    required this.color,
    required this.quantity,
    required this.unitPrice,
  });

  final String productId;
  final String size;
  final String color;
  final int quantity;
  final int unitPrice;

  String get key => '$productId|$size|$color';

  int get totalPrice => unitPrice * quantity;

  CartItem copyWith({
    String? productId,
    String? size,
    String? color,
    int? quantity,
    int? unitPrice,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      size: size ?? this.size,
      color: color ?? this.color,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  @override
  List<Object?> get props => [productId, size, color, quantity, unitPrice];
}
