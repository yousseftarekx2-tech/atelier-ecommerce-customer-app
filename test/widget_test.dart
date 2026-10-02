import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:atelier_customer/features/cart/cubit/cart_cubit.dart';
import 'package:atelier_customer/features/cart/cubit/cart_state.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('cart adds and aggregates identical variants', () async {
    final preferences = await SharedPreferences.getInstance();
    final cubit = CartCubit(preferences);

    await Future<void>.delayed(Duration.zero);

    cubit.addItem(
      productId: '001',
      size: 'M',
      color: 'Black',
      unitPrice: 1200,
    );
    cubit.addItem(
      productId: '001',
      size: 'M',
      color: 'Black',
      unitPrice: 1200,
    );

    expect(cubit.state, isA<CartUpdated>());
    expect(cubit.state.items, hasLength(1));
    expect(cubit.state.items.single.quantity, 2);
    expect(cubit.state.itemCount, 2);
    expect(cubit.state.totalPrice, 2400);

    await cubit.close();
  });

  test('cart restores persisted items', () async {
    SharedPreferences.setMockInitialValues({
      'atelier_cart': [
        '{"productId":"001","size":"M","color":"Black","quantity":2,"unitPrice":1200}',
      ],
    });

    final preferences = await SharedPreferences.getInstance();
    final cubit = CartCubit(preferences);

    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.items, hasLength(1));
    expect(cubit.state.items.single.productId, '001');
    expect(cubit.state.items.single.quantity, 2);
    expect(cubit.state.totalPrice, 2400);

    await cubit.close();
  });
}
