import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_api_remote/src/models/models.dart';
import 'package:user_api_remote/src/shared_preferences_token_storage.dart';

///
typedef JsonType = Map<String, dynamic>;

/// {@template user_api_remote}
/// Remote user API
/// {@endtemplate}
class UserApiRemote {
  /// {@macro user_api_remote}
  UserApiRemote({
    Dio? httpClient,
    required SharedPreferences pref,
  }) : _httpClient = (httpClient ?? Dio())..interceptors.add(LogInterceptor()) {
    _fresh = Fresh.oAuth2(
      tokenStorage: SharedPreferencesTokenStorage(pref),
      refreshToken: (token, httpClient) => throw RevokeTokenException(),
    );
    _httpClient.interceptors.add(_fresh);
  }

  final Dio _httpClient;

  ///
  Stream<AuthenticationStatus> get authenticationStatus =>
      _fresh.authenticationStatus;

  static late final Fresh<OAuth2Token> _fresh;

  /// User requests OTP code with his phone number
  Future<bool> requestOtpCode(String phoneNumber) async {
    try {
      final data = {'phone': phoneNumber};
      final response = await _httpClient.post<JsonType>(
        '/api/validate_send_otp/',
        data: data,
      );
      final status = response.data?['status'] as bool;
      return status;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  /// Submit phone number and OTP code
  Future<void> submitOtpCode(String phoneNumber, String code) async {
    try {
      final data = {
        'phone': phoneNumber,
        'otp': code,
      };
      final response = await _httpClient.post<JsonType>(
        '/api/validate_otp/',
        data: data,
      );
      final status = response.data?['status'] as bool;
      if (!status) throw Exception();
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  /// register
  Future<void> register(
    String fullName,
    String phoneNumber,
    String password,
  ) async {
    try {
      final data = {
        'name': fullName,
        'phone': phoneNumber,
        'password': password,
      };
      final response = await _httpClient.post<JsonType>(
        '/api/register/',
        data: data,
      );
      final status = response.data?['status'] as bool;
      if (!status) throw Exception();
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  /// login
  Future<User> login(
    String phoneNumber,
    String password,
  ) async {
    try {
      final data = {
        'phone': phoneNumber,
        'password': password,
      };
      final response = await _httpClient.post<JsonType>(
        '/api/login/',
        data: data,
      );
      final token = response.data?['token'] as String;
      final accessToken = OAuth2Token(accessToken: token, tokenType: 'Token');
      await _fresh.setToken(accessToken);

      final userMap = response.data?['user'] as JsonType;
      final user = User(
        userId: (userMap['id'] as int).toString(),
        name: response.data?['user_name'] as String,
        phoneNumber: userMap['phone'] as String,
      );
      return user;
    } on DioError catch (e) {
      await _fresh.revokeToken();
      throw Exception(e);
    }
  }

  ///
  Future<void> logout(String token) async {
    try {
      final data = {'token': token};
      final response = await _httpClient.post<JsonType>(
        '/api/logout/',
        data: data,
      );
      final status = response.data?['status'] as bool;
      if (!status) throw Exception();
    } on DioError catch (e) {
      throw Exception(e);
    }
  }
}
