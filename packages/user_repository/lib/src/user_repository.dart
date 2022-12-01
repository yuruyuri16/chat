import 'dart:convert';

import 'package:user_api_local/user_api_local.dart';
import 'package:user_api_remote/user_api_remote.dart';
import 'package:user_repository/src/models/models.dart';

/// {@template user_repository}
/// User repository
/// {@endtemplate}
class UserRepository {
  /// {@macro user_repository}
  UserRepository({
    required UserApiRemote userApiRemote,
    required UserApiLocal userApiLocal,
  })  : _userApiRemote = userApiRemote,
        _userApiLocal = userApiLocal;

  final UserApiRemote _userApiRemote;
  final UserApiLocal _userApiLocal;

  ///
  User get user => User.fromJson(_userApiLocal.read());

  ///
  Stream<AuthenticationStatus> get authenticationStatus =>
      _userApiRemote.authenticationStatus;

  ///
  Future<bool> requestOtpCode(String phoneNumber) async {
    return _userApiRemote.requestOtpCode(phoneNumber);
  }

  ///
  Future<void> submitOtpCode(String phoneNumber, String code) async {
    await _userApiRemote.submitOtpCode(phoneNumber, code);
  }

  ///
  Future<void> register(
    String fullName,
    String phoneNumber,
    String password,
  ) async {
    await _userApiRemote.register(fullName, phoneNumber, password);
  }

  ///
  Future<void> login(
    String phoneNumber,
    String password,
  ) async {
    final user = await _userApiRemote.login(phoneNumber, password);
    final userString = jsonEncode(user.toJson());
    await _userApiLocal.save(userString);
  }
}
