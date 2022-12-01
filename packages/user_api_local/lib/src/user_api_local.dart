import 'package:shared_preferences/shared_preferences.dart';

/// {@template user_api_local}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class UserApiLocal {
  /// {@macro user_api_local}
  UserApiLocal();

  late final SharedPreferences _plugin;

  static const _key = '__user__key__';

  ///
  Future<void> init() async {
    _plugin = await SharedPreferences.getInstance();
  }

  ///
  String read() {
    final result = _plugin.getString(_key);
    return result ?? '';
  }

  ///
  Future<void> save(String user) async {
    try {
      final success = await _plugin.setString(_key, user);
      if (!success) throw Exception();
    } catch (e) {
      throw Exception(e);
    }
  }

  ///
  Future<void> delete() async {
    try {
      final success = await _plugin.remove(_key);
      if (!success) throw Exception();
    } catch (e) {
      throw Exception(e);
    }
  }
}
