import 'package:atelier_customer/features/products/domain/entities/product.dart';
import 'package:atelier_customer/features/style/domain/entities/style_preferences.dart';
import 'package:atelier_customer/features/style/domain/service/personalization_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalizedProductsCubit extends Cubit<List<Product>> {
  PersonalizedProductsCubit({required this._personalizationService})
    : super(const []);

  final PersonalizationService _personalizationService;

  void update({
    required List<Product> products,
    required StylePreferences preferences,
  }) {
    emit(
      _personalizationService.rankProducts(
        products: products,
        preferences: preferences,
      ),
    );
  }

  void clear() {
    emit(const []);
  }
}
