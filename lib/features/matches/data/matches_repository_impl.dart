import 'package:dio/dio.dart';
import 'package:swan_match/core/constants/api_constants.dart';
import 'package:swan_match/core/storage/squlite_db_storage.dart';
import 'package:swan_match/features/matches/data/matches_repository.dart';
import 'package:swan_match/match_status.dart';
import 'package:swan_match/shared/models/user.dart';
import 'package:swan_match/core/network/api_client.dart';

class MatchRepositoryImpl implements MatchRepository {
  final ApiClient api;
  final SQLiteDbStorage sqlite;

  MatchRepositoryImpl(this.sqlite, this.api);

  @override
  Future<List<User>> getMatches(String status) async {
    return await sqlite.getProfiles(status: status);
  }

  @override
  Future<void> acceptRequest(String matchId) async {
    try {
      await api.put(
        ApiConstants.changeStatus,
        data: {"match_id": matchId, "status": MatchStatus.ACCEPTED.name},
      );

      await sqlite.changeMatchStatus(
        status: MatchStatus.ACCEPTED.name,
        matchId: matchId,
      );
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Something went wrong');
    }
  }

  @override
  Future<void> rejectRequest(String matchId) async {
    try {
      await api.put(
        ApiConstants.changeStatus,
        data: {"match_id": matchId, "status": MatchStatus.REJECTED.name},
      );

      await sqlite.changeMatchStatus(
        status: MatchStatus.REJECTED.name,
        matchId: matchId,
      );
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Something went wrong');
    }
  }

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
  Future<void> revokeRequest(String matchId) async {
    try {
      await api.put(
        ApiConstants.changeStatus,
        data: {"match_id": matchId, "status": MatchStatus.REJECTED.name},
      );

      await sqlite.changeMatchStatus(
        status: MatchStatus.REJECTED.name,
        matchId: matchId,
      );
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Something went wrong');
    }
  }

  @override
  Future<void> cancelRequest(String matchId) async {
    try {
      await api.put(
        ApiConstants.changeStatus,
        data: {"match_id": matchId, "status": MatchStatus.PASS.name},
      );

      await sqlite.changeMatchStatus(
        status: MatchStatus.PASS.name,
        matchId: matchId,
      );
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Something went wrong');
    }
  }
}
