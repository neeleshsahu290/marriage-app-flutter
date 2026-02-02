class StartupState {
  final bool splashFinished;
  final bool languageSelected;
  final bool welcomeSelected;
  final bool intentSelected;
  final bool isEmailOtpSent;
  final bool isOnoarding;
  final bool isLoggedIn;

  const StartupState({
    required this.splashFinished,
    required this.languageSelected,
    required this.welcomeSelected,
    required this.intentSelected,
    required this.isLoggedIn,
    required this.isOnoarding,
    required this.isEmailOtpSent,
  });

  factory StartupState.initial({
    required bool splashFinished,
    required bool languageSelected,
    required bool welcomeSelected,
    required bool intentSelected,
    required bool isLoggedIn,
    required bool isOnoarding,
    required bool isEmailOtpSent,
  }) {
    return StartupState(
      splashFinished: splashFinished,
      languageSelected: languageSelected,
      welcomeSelected: welcomeSelected,
      intentSelected: intentSelected,
      isLoggedIn: isLoggedIn,
      isOnoarding: isOnoarding,
      isEmailOtpSent: isEmailOtpSent
    );
  }

  StartupState copyWith({
    bool? splashFinished,
    bool? languageSelected,
    bool? welcomeSelected,
    bool? intentSelected,
    bool? isLoggedIn,
    bool? isEmailOtpSent,
    bool? isOnoarding
  }) {
    return StartupState(
      splashFinished: splashFinished ?? this.splashFinished,
      languageSelected: languageSelected ?? this.languageSelected,
      intentSelected: intentSelected ?? this.intentSelected,
      welcomeSelected: welcomeSelected ?? this.welcomeSelected,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isOnoarding: isOnoarding?? this.isOnoarding,
      isEmailOtpSent: isEmailOtpSent?? this.isEmailOtpSent
    );
  }
}
