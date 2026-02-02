import 'package:swan_match/shared/models/user.dart';

abstract class HomeRepository {
  Future<List<User>> getRecommendedMatches(status);

  Future<List<User>> getAllMatches();

  Future<void> passRequest(String matchId);

  Future<void> sentRequest(String userId, String? matchId);
}
