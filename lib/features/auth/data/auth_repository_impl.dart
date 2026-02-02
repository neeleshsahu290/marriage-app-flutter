import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:swan_match/core/constants/api_constants.dart';
import 'package:swan_match/core/network/api_client.dart';
import 'package:swan_match/core/storage/app_prefs.dart';
import 'package:swan_match/core/storage/pref_names.dart';
import 'package:swan_match/features/auth/data/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient api;

  AuthRepositoryImpl(this.api);

  @override
  Future<void> sendEmailOtp(String email) async {
    try {
      await api.post(ApiConstants.sendEmailOtp, data: {'email': email});
    } on DioException catch (e) {
      throw e.message ?? 'Something went wrong';
    }
  }

  @override
  Future<void> verifyEmailOtp({
    required String email,
    required String otp,
  }) async {
    log('verifyEmailOtp → email: $email, otp: $otp');

    try {
      await api.post(
        ApiConstants.verifyEmailOtp,
        data: {'email': email, 'otp': otp},
      );
    } on DioException catch (e) {
      throw e.message ?? 'Something went wrong';
    }
  }

  @override
  Future<void> sendPhoneOtp(String phone) async {
    try {
      await api.post(ApiConstants.sendPhoneOtp, data: {'phone': phone});
    } on DioException catch (e) {
      throw e.message ?? 'Something went wrong';
    }
  }

  @override
  Future<void> verifyPhoneOtp({
    required String phone,
    required String otp,
  }) async {
    try {
      await api.post(
        ApiConstants.verifyPhoneOtp,
        data: {'phone': phone, 'otp': otp},
      );
    } on DioException catch (e) {
      throw e.message ?? 'Something went wrong';
    }
  }

  @override
  Future<void> createUser({
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      await api.post(
        ApiConstants.createUser,
        data: {'phone': phone, 'email': email, 'password': password},
      );

      await AppPrefs.setBool(PrefNames.isLoggedIn, true);
    } on DioException catch (e) {
      throw e.message ?? 'Something went wrong';
    }
  }

  @override
  Future<void> sendLoginOtp(String identifier) async {
    try {
      await api.post(
        ApiConstants.sendLoginOtp,
        data: {'identifier': identifier},
      );
    } on DioException catch (e) {
      throw e.message ?? 'Something went wrong';
    }
  }

  @override
  Future<void> loginWithPassword({
    required String identifier,

    required String password,
  }) async {
    try {
      final response = await api.post(
        ApiConstants.loginEndpoint,
        data: {'identifier': identifier, 'password': password},
      );
      // log(response.data.toString());
      // print(response.data);

      var data = response.data['data'];
      await AppPrefs.setString(PrefNames.authToken, data['access_token']);
      var user = data['user'];
      await AppPrefs.setString(PrefNames.userId, user['user_id']);
      await AppPrefs.setString(PrefNames.email, user['email']);
      await AppPrefs.setString(PrefNames.phone, user['phone']);

      await AppPrefs.setBool(PrefNames.isActive, user['is_active']);

      await AppPrefs.setBool(
        PrefNames.showOnlineStatus,
        user['show_online_status'],
      );

      await AppPrefs.setBool(PrefNames.showEmail, user['show_email']);

      await AppPrefs.setBool(PrefNames.showPhone, user['show_phone']);

      await AppPrefs.setString(
        PrefNames.photoVisibility,
        user['photo_visibility'],
      );

      await AppPrefs.setBool(
        PrefNames.onboardingCompleted,
        user['onboarding_completed'],
      );

      await AppPrefs.setString(
        PrefNames.userProfile,
        jsonEncode(user['profile']),
      );

      // await AppPrefs.setBool(
      //   PrefNames.isOnboardingCompleted,
      //   user['onboarding_completed'],
      // );

      await AppPrefs.setBool(PrefNames.isOnboardingCompleted, false);
      await AppPrefs.setBool(PrefNames.isLoggedIn, true);
    } on DioException catch (e) {
      throw e.message ?? 'Something went wrong';
    }
  }
}
