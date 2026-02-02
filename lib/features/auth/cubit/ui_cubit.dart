import 'package:flutter_bloc/flutter_bloc.dart';
import 'ui_state.dart';

class UiCubit extends Cubit<UiState> {
  UiCubit() : super(const UiState());

  void setLoading(bool value) {
    emit(state.copyWith(isLoading: value));
  }

  void setDisabled(bool value) {
    emit(state.copyWith(isDisabled: value));
  }

  void reset() {
    emit(const UiState());
  }
}
