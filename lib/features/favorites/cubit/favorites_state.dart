import 'package:equatable/equatable.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState({
    required this.productIds,
    this.isLoading = false,
    this.errorMessage,
  });

  final Set<String> productIds;
  final bool isLoading;
  final String? errorMessage;

  @override
  List<Object?> get props => [productIds, isLoading, errorMessage];
}

final class FavoritesInitial extends FavoritesState {
  const FavoritesInitial() : super(productIds: const {}, isLoading: true);
}

final class FavoritesUpdated extends FavoritesState {
  const FavoritesUpdated(
    Set<String> productIds, {
    super.isLoading,
    super.errorMessage,
  }) : super(
        productIds: productIds,
      );
}
