import 'package:equatable/equatable.dart';

import '../domain/entities/cart_item.dart';

sealed class CartState extends Equatable {
  const CartState(this.items);

  final List<CartItem> items;

  int get itemCount {
    var count = 0;

    for (final item in items) {
      count += item.quantity;
    }

    return count;
  }

  int get totalPrice {
    var total = 0;

    for (final item in items) {
      total += item.totalPrice;
    }

    return total;
  }

  @override
  List<Object?> get props => [items];
}

final class CartInitial extends CartState {
  const CartInitial() : super(const []);
}

final class CartUpdated extends CartState {
  const CartUpdated(super.items);
}
