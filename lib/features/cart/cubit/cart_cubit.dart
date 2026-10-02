import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/entities/cart_item.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this._preferences) : super(const CartInitial()) {
    _loadCart();
  }

  static const _storageKey = 'atelier_cart';

  final SharedPreferences _preferences;

  Future<void> _loadCart() async {
    try {
      final rawItems = _preferences.getStringList(_storageKey) ?? const [];
      final items = rawItems
          .map((raw) => jsonDecode(raw))
          .whereType<Map>()
          .map((item) {
            return CartItem(
              productId: item['productId'] as String,
              size: item['size'] as String,
              color: item['color'] as String,
              quantity: (item['quantity'] as num).toInt(),
              unitPrice: (item['unitPrice'] as num).toInt(),
            );
          })
          .where((item) => item.quantity > 0)
          .toList();

      if (!isClosed) {
        emit(CartUpdated(items));
      }
    } catch (_) {
      await _preferences.remove(_storageKey);

      if (!isClosed) {
        emit(const CartUpdated([]));
      }
    }
  }

  Future<void> _persist(List<CartItem> items) async {
    final rawItems = items
        .map(
          (item) => jsonEncode({
            'productId': item.productId,
            'size': item.size,
            'color': item.color,
            'quantity': item.quantity,
            'unitPrice': item.unitPrice,
          }),
        )
        .toList();

    await _preferences.setStringList(_storageKey, rawItems);
  }

  void addItem({
    required String productId,
    required String size,
    required String color,
    required int unitPrice,
  }) {
    final key = '$productId|$size|$color';
    final existingIndex = state.items.indexWhere((item) => item.key == key);

    final updatedItems = [...state.items];

    if (existingIndex == -1) {
      updatedItems.add(
        CartItem(
          productId: productId,
          size: size,
          color: color,
          quantity: 1,
          unitPrice: unitPrice,
        ),
      );
    } else {
      final existingItem = updatedItems[existingIndex];
      updatedItems[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + 1,
      );
    }

    emit(CartUpdated(updatedItems));
    unawaited(_persist(updatedItems));
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
    _persist(updatedItems);
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
    _persist(updatedItems);
  }

  void clear() {
    emit(const CartUpdated([]));
    unawaited(_preferences.remove(_storageKey));
  }

  CartItem? _findItem(String itemKey) {
    for (final item in state.items) {
      if (item.key == itemKey) {
        return item;
      }
    }

    return null;
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
