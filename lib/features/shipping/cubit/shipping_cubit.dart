import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/entities/shipping_method.dart';
import 'shipping_state.dart';

class ShippingCubit extends Cubit<ShippingState> {
  ShippingCubit({required int subtotal})
    : super(ShippingInitial(subtotal: subtotal));

  void selectMethod(ShippingMethod method) {
    emit(ShippingUpdated(selectedMethod: method, subtotal: state.subtotal));
  }

  void updateSubtotal(int subtotal) {
    emit(
      ShippingUpdated(selectedMethod: state.selectedMethod, subtotal: subtotal),
    );
  }
}
