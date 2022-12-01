import 'dart:convert';

import 'package:fresh_dio/fresh_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template shared_preferences_token_storage}
///
/// {@endtemplate}
class SharedPreferencesTokenStorage implements TokenStorage<OAuth2Token> {
  /// {@macro shared_preferences_token_storage}
  const SharedPreferencesTokenStorage(this._plugin);

  final SharedPreferences _plugin;

  static const _tokenKey = '__token__key__';

  @override
  Future<void> delete() async {
    await _plugin.remove(_tokenKey);
  }

  @override
  Future<OAuth2Token?> read() async {
    final token = _plugin.getString(_tokenKey);
    if (token == null) return null;
    final tokenMap = jsonDecode(token) as Map<String, dynamic>;
    return OAuth2Token(
      accessToken: tokenMap['accessToken'] as String,
      tokenType: tokenMap['tokenType'] as String?,
      expiresIn: tokenMap['expiresIn'] as int?,
      refreshToken: tokenMap['refreshToken'] as String?,
      scope: tokenMap['tokenMap'] as String?,
    );
  }

  @override
  Future<void> write(OAuth2Token token) async {
    final data = {
      'accessToken': token.accessToken,
      'tokenType': token.tokenType,
      'expiresIn': token.expiresIn,
      'refreshToken': token.refreshToken,
      'scope': token.scope,
    };
    await _plugin.setString(_tokenKey, jsonEncode(data));
  }
}
