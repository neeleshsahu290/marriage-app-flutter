import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swan_match/core/storage/squlite_db_storage.dart';
import 'package:swan_match/features/home/data/home_repository.dart';
import 'package:swan_match/shared/models/user.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  bool isLoaded = false;
  final HomeRepository repository;

  HomeCubit(this.repository) : super(HomeState.initial());

  Future<void> loadHomeMatches(status) async {
    emit(state.copyWith(status: HomeStatus.loading));
    await Future.delayed(Duration(milliseconds: 200));

    //if (state.status == HomeStatus.success) return;
    try {
      if (isLoaded == false || state.matches.isEmpty) {
        await SQLiteDbStorage.clearFullDb();

        await repository.getAllMatches();
      }

      await Future.delayed(Duration(milliseconds: 200));
      isLoaded = true;

      final matches = await repository.getRecommendedMatches(status);

      if (matches.isEmpty) {
        emit(state.copyWith(status: HomeStatus.empty, matches: []));
      } else {
        emit(state.copyWith(status: HomeStatus.success, matches: matches));
      }
    } catch (e) {
      emit(
        state.copyWith(status: HomeStatus.error, errorMessage: e.toString()),
      );
    }
  }

  void removeMatch(String matchId) {
    final updatedList = List<User>.from(state.matches)
      ..removeWhere((u) => u.matchId == matchId);

    emit(
      state.copyWith(
        matches: updatedList,
        status: updatedList.isEmpty ? HomeStatus.empty : HomeStatus.success,
      ),
    );
  }

  // getAllMatches() async {
  //   try {
  //     await repository.getAllMatches();
  //   } catch (e) {
  //     log("error in getAllMatches $e");
  //   }
  // }

  sendRequest(String matchId, String userId) async {
    removeMatch(matchId);
    repository.sentRequest(userId, matchId);
  }

  passRequest(String matchId) async {
    removeMatch(matchId);
    repository.passRequest(matchId);
  }
}
