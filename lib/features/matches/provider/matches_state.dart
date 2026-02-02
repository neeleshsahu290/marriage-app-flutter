import 'package:swan_match/shared/models/user.dart';

enum MatchStatusType { received, accepted, sent }

enum MatchesLoadStatus { initial, loading, success, empty, error }

class MatchesState {
  final List<User> received;
  final List<User> accepted;
  final List<User> sent;

  final MatchesLoadStatus receivedStatus;
  final MatchesLoadStatus acceptedStatus;
  final MatchesLoadStatus sentStatus;

  final String? error;

  const MatchesState({
    required this.received,
    required this.accepted,
    required this.sent,
    required this.receivedStatus,
    required this.acceptedStatus,
    required this.sentStatus,
    this.error,
  });

  factory MatchesState.initial() {
    return const MatchesState(
      received: [],
      accepted: [],
      sent: [],
      receivedStatus: MatchesLoadStatus.initial,
      acceptedStatus: MatchesLoadStatus.initial,
      sentStatus: MatchesLoadStatus.initial,
    );
  }

  MatchesState copyWith({
    List<User>? received,
    List<User>? accepted,
    List<User>? sent,
    MatchesLoadStatus? receivedStatus,
    MatchesLoadStatus? acceptedStatus,
    MatchesLoadStatus? sentStatus,
    String? error,
  }) {
    return MatchesState(
      received: received ?? this.received,
      accepted: accepted ?? this.accepted,
      sent: sent ?? this.sent,
      receivedStatus: receivedStatus ?? this.receivedStatus,
      acceptedStatus: acceptedStatus ?? this.acceptedStatus,
      sentStatus: sentStatus ?? this.sentStatus,
      error: error,
    );
  }
}
