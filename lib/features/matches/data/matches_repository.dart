import 'package:swan_match/shared/models/user.dart';

abstract class MatchRepository {
  Future<List<User>> getMatches(String status);

  Future<void> acceptRequest(String matchId);
  Future<void> rejectRequest(String matchId);
  Future<void> revokeRequest(String matchId);
  Future<void> passRequest(String matchId);
  Future<void> cancelRequest(String matchId);
}
