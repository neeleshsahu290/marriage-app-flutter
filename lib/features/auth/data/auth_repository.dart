abstract class AuthRepository {
  // Email OTP
  Future<void> sendEmailOtp(String email);
  Future<void> verifyEmailOtp({required String email, required String otp});

  // Phone OTP
  Future<void> sendPhoneOtp(String phone);
  Future<void> verifyPhoneOtp({required String phone, required String otp});

  // User creation
  Future<void> createUser({
    required String phone,
    required String email,
    required String password,
  });

  // Login flow
  Future<void> sendLoginOtp(String identifier);

  Future<void> loginWithPassword({
    required String identifier,

    required String password,
  });
}
