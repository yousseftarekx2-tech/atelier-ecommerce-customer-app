import 'package:equatable/equatable.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState(this.productIds);

  final Set<String> productIds;

  @override
  List<Object?> get props => [productIds];
}

final class FavoritesInitial extends FavoritesState {
  const FavoritesInitial() : super(const {});
}

final class FavoritesUpdated extends FavoritesState {
  const FavoritesUpdated(super.productIds);
}
