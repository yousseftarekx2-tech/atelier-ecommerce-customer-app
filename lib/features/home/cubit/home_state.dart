import 'package:equatable/equatable.dart';

import '../../products/domain/entities/product.dart';

sealed class HomeState extends Equatable {
  const HomeState({
    this.pickedForYou = const [],
    this.trendingNow = const [],
    this.newArrivals = const [],
    this.searchQuery = '',
    this.searchResults = const [],
  });

  final List<Product> pickedForYou;
  final List<Product> trendingNow;
  final List<Product> newArrivals;
  final String searchQuery;
  final List<Product> searchResults;

  bool get isSearching => searchQuery.trim().isNotEmpty;

  @override
  List<Object?> get props => [
    pickedForYou,
    trendingNow,
    newArrivals,
    searchQuery,
    searchResults,
  ];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading({
    super.pickedForYou,
    super.trendingNow,
    super.newArrivals,
    super.searchQuery,
    super.searchResults,
  });
}

final class HomeLoaded extends HomeState {
  const HomeLoaded({
    required super.pickedForYou,
    required super.trendingNow,
    required super.newArrivals,
    super.searchQuery,
    super.searchResults,
  });
}

final class HomeError extends HomeState {
  const HomeError({
    required this.message,
    super.pickedForYou,
    super.trendingNow,
    super.newArrivals,
    super.searchQuery,
    super.searchResults,
  });

  final String message;

  @override
  List<Object?> get props => [...super.props, message];
}
