import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/entities/cart_item.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartInitial());

  void addItem({
    required String productId,
    required String size,
    required String color,
    required int unitPrice,
  }) {
    final key = '$productId|$size|$color';

    final existingIndex = state.items.indexWhere((item) => item.key == key);

    if (existingIndex == -1) {
      emit(
        CartUpdated([
          ...state.items,
          CartItem(
            productId: productId,
            size: size,
            color: color,
            quantity: 1,
            unitPrice: unitPrice,
          ),
        ]),
      );
      return;
    }

    final updatedItems = [...state.items];
    final existingItem = updatedItems[existingIndex];

    updatedItems[existingIndex] = existingItem.copyWith(
      quantity: existingItem.quantity + 1,
    );

    emit(CartUpdated(updatedItems));
  }

  void updateQuantity({required String itemKey, required int quantity}) {
    if (quantity <= 0) {
      removeItem(itemKey);
      return;
    }

    final updatedItems = state.items.map((item) {
      if (item.key != itemKey) {
        return item;
      }

      return item.copyWith(quantity: quantity);
    }).toList();

    emit(CartUpdated(updatedItems));
  }

  void increment(String itemKey) {
    final item = _findItem(itemKey);

    if (item == null) {
      return;
    }

    updateQuantity(itemKey: itemKey, quantity: item.quantity + 1);
  }

  void decrement(String itemKey) {
    final item = _findItem(itemKey);

    if (item == null) {
      return;
    }

    updateQuantity(itemKey: itemKey, quantity: item.quantity - 1);
  }

  void removeItem(String itemKey) {
    final updatedItems = state.items
        .where((item) => item.key != itemKey)
        .toList();

    emit(CartUpdated(updatedItems));
  }

  void clear() {
    emit(const CartUpdated([]));
  }

  CartItem? _findItem(String itemKey) {
    for (final item in state.items) {
      if (item.key == itemKey) {
        return item;
      }
    }

    return null;
  }
}
