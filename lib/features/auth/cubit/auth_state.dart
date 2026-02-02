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

  const AuthState({
    required this.email,
    required this.phone,
    required this.password,
  });

  factory AuthState.initial() => const AuthState(
        email: '',
        phone: '',
        password: '',
      );

  AuthState copyWith({
    String? email,
    String? phone,
    String? password,
  }) {
    return AuthState(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }
}
