import 'package:swan_match/features/matches/data/matches_repository.dart';
import 'package:swan_match/features/matches/provider/matches_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swan_match/match_status.dart';
import 'package:swan_match/shared/models/user.dart';

class MatchesCubit extends Cubit<MatchesState> {
  final MatchRepository repository;

  MatchesCubit(this.repository) : super(MatchesState.initial());

  // ================= LOADERS =================

  Future<void> loadAll() async =>
      Future.wait([loadReceived(), loadAccepted(), loadSent()]);

  Future<void> _load(
    MatchStatus status,
    void Function(List<User>) setList,
    void Function(MatchesLoadStatus) setStatus,
  ) async {
    setStatus(MatchesLoadStatus.loading);

    try {
      final list = await repository.getMatches(status.name);

      setList(list);
      setStatus(
        list.isEmpty ? MatchesLoadStatus.empty : MatchesLoadStatus.success,
      );
    } catch (e) {
      setStatus(MatchesLoadStatus.error);
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> loadReceived() async => _load(
    MatchStatus.RECIEVED,
    (list) => emit(state.copyWith(received: list)),
    (s) => emit(state.copyWith(receivedStatus: s)),
  );

  Future<void> loadAccepted() async => _load(
    MatchStatus.ACCEPTED,
    (list) => emit(state.copyWith(accepted: list)),
    (s) => emit(state.copyWith(acceptedStatus: s)),
  );

  Future<void> loadSent() async => _load(
    MatchStatus.SENT,
    (list) => emit(state.copyWith(sent: list)),
    (s) => emit(state.copyWith(sentStatus: s)),
  );

  // ================= ACTIONS =================

  Future<void> acceptRequest(String id) async {
    await repository.acceptRequest(id);
    removeRecieved(id);
    await loadAccepted();
  }

  Future<void> rejectRequest(String id) async {
    removeRecieved(id);
    await repository.rejectRequest(id);
  }

  Future<void> removeRequest(String id) async {
    removeAccepted(id);
    await repository.revokeRequest(id);
  }

  Future<void> cancelRequest(String id) async {
    removeSent(id);
    await repository.cancelRequest(id);
  }

  // ================= LOCAL REMOVERS =================

  void _remove(
    List<User> list,
    String id,
    void Function(List<User>) setList,
    void Function(MatchesLoadStatus) setStatus,
  ) {
    final updated = List<User>.from(list)..removeWhere((u) => u.matchId == id);

    setList(updated);
    setStatus(
      updated.isEmpty ? MatchesLoadStatus.empty : MatchesLoadStatus.success,
    );
  }

  void removeSent(String id) => _remove(
    state.sent,
    id,
    (l) => emit(state.copyWith(sent: l)),
    (s) => emit(state.copyWith(sentStatus: s)),
  );

  void removeRecieved(String id) => _remove(
    state.received,
    id,
    (l) => emit(state.copyWith(received: l)),
    (s) => emit(state.copyWith(receivedStatus: s)),
  );

  void removeAccepted(String id) => _remove(
    state.accepted,
    id,
    (l) => emit(state.copyWith(accepted: l)),
    (s) => emit(state.copyWith(acceptedStatus: s)),
  );
}
