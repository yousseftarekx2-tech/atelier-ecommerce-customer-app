import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/repositories/recently_viewed_repository.dart';
import 'recently_viewed_state.dart';

class RecentlyViewedCubit extends Cubit<RecentlyViewedState> {
  RecentlyViewedCubit(this._repository) : super(const RecentlyViewedState());

  final RecentlyViewedRepository _repository;

  Future<void> loadRecentlyViewed() async {
    emit(state.copyWith(status: RecentlyViewedStatus.loading));

    try {
      final productIds = await _repository.getRecentlyViewedIds();

      emit(
        state.copyWith(
          status: RecentlyViewedStatus.loaded,
          productIds: productIds,
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: RecentlyViewedStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> addProduct(String productId) async {
    try {
      await _repository.addProduct(productId);

      final productIds = await _repository.getRecentlyViewedIds();

      emit(
        state.copyWith(
          status: RecentlyViewedStatus.loaded,
          productIds: productIds,
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: RecentlyViewedStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> clear() async {
    try {
      await _repository.clear();

      emit(
        state.copyWith(
          status: RecentlyViewedStatus.loaded,
          productIds: const [],
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: RecentlyViewedStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
