part of 'auth_cubit.dart';

// enum AuthStatus {
//   initial,
//   loading,
//   otpSent,
//   otpVerified,
//   authenticated,
//   userCreated,
//   error,
// }

class AuthState {
  final String email;
  final String phone;
  final String password;
  final bool emailVerified;
  final bool phoneVerified;

  const AuthState({
    required this.email,
    required this.phone,
    required this.password,
    required this.emailVerified,
    required this.phoneVerified,
  });

  factory AuthState.initial() => const AuthState(
    email: '',
    phone: '',
    password: '',
    emailVerified: false,
    phoneVerified: false,
  );

  AuthState copyWith({
    String? email,
    String? phone,
    String? password,
    bool? emailVerified,
    bool? phoneVerified,
  }) {
    return AuthState(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      emailVerified: emailVerified ?? this.emailVerified,
      phoneVerified: phoneVerified ?? this.phoneVerified,
    );
  }
}
