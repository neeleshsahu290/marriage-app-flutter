import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swan_match/core/utils/utils.dart';
import 'package:swan_match/features/auth/data/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  AuthCubit(this.repository) : super(AuthState.initial());

  // Login User
  Future<bool> loginUser({
    required String identifier,
    required String password,
  }) async {
    try {
      await repository.loginWithPassword(
        identifier: identifier,
        password: password,
      );
      return true;
    } catch (e) {
      Utils.showError(e.toString());
      return false;
    }
  }

  // Send Email OTP
  Future<bool> sendEmailOtp(String email) async {
    try {
      await repository.sendEmailOtp(email);
      emit(state.copyWith(email: email));
      return true;
    } catch (e) {
      Utils.showError(e.toString());
      return false;
    }
  }

  // Send Phone OTP
  Future<bool> sendPhoneOtp(String phone) async {
    try {
      await repository.sendPhoneOtp(phone);
      emit(state.copyWith(phone: phone));

      return true;
    } catch (e) {
      Utils.showError(e.toString());
      return false;
    }
  }

  // Verify Email OTP
  Future<bool> verifyEmailOtp({required String otp}) async {
    try {
      await repository.verifyEmailOtp(email: state.email, otp: otp);
      return true;
    } catch (e) {
      Utils.showError(e.toString());
      return false;
    }
  }

  // Verify Phone OTP
  Future<bool> verifyPhoneOtp({required String otp}) async {
    try {
      await repository.verifyPhoneOtp(phone: state.phone, otp: otp);
      return true;
    } catch (e) {
      Utils.showError(e.toString());
      return false;
    }
  }

  // Create User
  Future<bool> createUser({required String password}) async {
    try {
      await repository.createUser(
        phone: state.phone,
        email: state.email,
        password: password,
      );
      return true;
    } catch (e) {
      Utils.showError(e.toString());
      return false;
    }
  }

  // Login Flow (Step 1 → Send OTP)
  // Future<void> sendLoginOtp(String identifier) async {
  //   emit(state.copyWith(status: AuthStatus.loading));
  //   try {
  //     await repository.sendLoginOtp(identifier);
  //     emit(
  //       state.copyWith(status: AuthStatus.otpSent, message: 'Login OTP sent'),
  //     );
  //   } catch (e) {
  //     emit(state.copyWith(status: AuthStatus.error, message: e.toString()));
  //   }
  // }

  // // Login Flow (Step 2 → Verify OTP + Password)
  // Future<void> loginWithPassword({
  //   required String identifier,
  //   required String otp,
  //   required String password,
  // }) async {
  //   emit(state.copyWith(status: AuthStatus.loading));
  //   try {
  //     final token = await repository.loginWithPassword(
  //       identifier: identifier,
  //       otp: otp,
  //       password: password,
  //     );
  //     emit(state.copyWith(status: AuthStatus.authenticated, token: token));
  //   } catch (e) {
  //     emit(state.copyWith(status: AuthStatus.error, message: e.toString()));
  //   }
  // }
}
