import 'package:equatable/equatable.dart';

import '../domain/entities/shipping_method.dart';

sealed class ShippingState extends Equatable {
  const ShippingState({required this.selectedMethod, required this.subtotal});

  final ShippingMethod selectedMethod;
  final int subtotal;

  int get shippingCost {
    if (selectedMethod.id == ShippingMethod.standard.id) {
      return subtotal >= 5000 ? 0 : 80;
    }

    return 150;
  }

  int get total => subtotal + shippingCost;

  @override
  List<Object> get props => [selectedMethod, subtotal];
}

final class ShippingInitial extends ShippingState {
  const ShippingInitial({required super.subtotal})
    : super(selectedMethod: ShippingMethod.standard);
}

final class ShippingUpdated extends ShippingState {
  const ShippingUpdated({
    required super.selectedMethod,
    required super.subtotal,
  });
}
