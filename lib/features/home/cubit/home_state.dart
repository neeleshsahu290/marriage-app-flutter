import 'package:swan_match/shared/models/user.dart';

enum HomeStatus { initial, loading, success, empty, error }

class HomeState {
  final HomeStatus status;
  final List<User> matches;
  final String? errorMessage;

  const HomeState({
    required this.status,
    this.matches = const [],
    this.errorMessage,
  });

  factory HomeState.initial() {
    return const HomeState(status: HomeStatus.initial);
  }

  HomeState copyWith({
    HomeStatus? status,
    List<User>? matches,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      matches: matches ?? this.matches,
      errorMessage: errorMessage,
    );
  }
}
