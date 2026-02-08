class ApiConstants {
  ApiConstants._();

  static const bool isProd = true;

  static const String baseUrl = isProd
      ? 'https://marriage-app-backend.onrender.com/api'
      : 'http://192.168.29.252:4000/api';

  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String userProfileEndpoint = '/user/profile';

  static const String sendEmailOtp = "/auth/send-email-otp";
  static const String verifyEmailOtp = "/auth/verify-email-otp";
  static const String createUser = "/auth/users";

  static const String sendPhoneOtp = "/auth/send-phone-otp";
  static const String verifyPhoneOtp = "/auth/verify-phone-otp";

  static const String getAllMatches = "/matches/all";

  static String sendLoginOtp = "";

  static const String updateUserFeild = "/users/update-field";

  static const String updateUserFeilds = "/users/update-fields";

  static const String createMatches = "/matches/create-matches";

  static const String sendRequest = "/matches/send";
  static const String passRequest = "/matches/pass";
  static const String changeStatus = "/matches/status";
  static const String blockRequest = "/matches/block";

  static String saveProfile = "/users/profile";

  static String updatePreferences = "/users/preferences";
}
