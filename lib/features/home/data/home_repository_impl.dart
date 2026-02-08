import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:swan_match/core/constants/api_constants.dart';
import 'package:swan_match/core/network/api_client.dart';
import 'package:swan_match/core/storage/squlite_db_storage.dart';
import 'package:swan_match/core/utils/pref_utils.dart';
import 'package:swan_match/features/home/data/home_repository.dart';
import 'package:swan_match/match_status.dart';
import 'package:swan_match/shared/models/user.dart';

class HomeRepositoryImpl implements HomeRepository {
  final SQLiteDbStorage sqlite;
  final ApiClient api;

  HomeRepositoryImpl(this.sqlite, this.api);

  @override
  Future<List<User>> getRecommendedMatches(status) async {
    return await sqlite.getProfiles(status: status);
  }

  @override
  Future<List<User>> getAllMatches() async {
    try {
      if (await PrefUtils.canApiCallAgain()) {
        try {
          await api.post(ApiConstants.createMatches);
          await PrefUtils.saveApiCallDate();
        } catch (e) {}
      }

      final response = await api.get(ApiConstants.getAllMatches);
      log(response.toString());
      final List data = response.data['data'];

      var list = data.map((e) => User.fromJson(e)).toList();

      await sqlite.insertMatches(list);
      return list;
    } on DioException catch (e) {
      log(e.toString());
      throw e.message ?? 'Something went wrong';
    }
  }

  // @override
  // Future<void> changeStatus(String matchId,) async {
  //   await sqlite.changeMatchStatus(status: status, matchId: matchId);
  // }

  @override
  Future<void> passRequest(String matchId) async {
    try {
      await api.put(ApiConstants.passRequest, data: {"match_id": matchId});

      await sqlite.changeMatchStatus(
        status: MatchStatus.PASS.name,
        matchId: matchId,
      );
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Something went wrong');
    }
  }

  @override
  Future<void> sentRequest(String userId, String? matchId) async {
    try {
      await api.post(
        ApiConstants.sendRequest, // POST endpoint
        data: {"receiver_id": userId},
      );

      // Update local DB only if old match exists
      if (matchId != null) {
        await sqlite.changeMatchStatus(
          status: MatchStatus.SENT.name,
          matchId: matchId,
        );
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Something went wrong');
    }
  }
}
