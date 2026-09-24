enum RecentlyViewedStatus { initial, loading, loaded, error }

class RecentlyViewedState {
  const RecentlyViewedState({
    this.status = RecentlyViewedStatus.initial,
    this.productIds = const [],
    this.errorMessage,
  });

  final RecentlyViewedStatus status;
  final List<String> productIds;
  final String? errorMessage;

  RecentlyViewedState copyWith({
    RecentlyViewedStatus? status,
    List<String>? productIds,
    String? errorMessage,
  }) {
    return RecentlyViewedState(
      status: status ?? this.status,
      productIds: productIds ?? this.productIds,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
