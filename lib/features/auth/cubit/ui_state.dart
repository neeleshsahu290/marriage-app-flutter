class UiState {
  final bool isLoading;
  final bool isDisabled;

  const UiState({
    this.isLoading = false,
    this.isDisabled = false,
  });

  UiState copyWith({
    bool? isLoading,
    bool? isDisabled,
  }) {
    return UiState(
      isLoading: isLoading ?? this.isLoading,
      isDisabled: isDisabled ?? this.isDisabled,
    );
  }
}
