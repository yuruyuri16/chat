import 'package:chat_api_remote/chat_api_remote.dart';
import 'package:crypto_api/crypto_api.dart';

/// {@template chat_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class ChatRepository {
  /// {@macro chat_repository}
  const ChatRepository({
    required ChatApiRemote chatApiRemote,
  }) : _chatApiRemote = chatApiRemote;

  final ChatApiRemote _chatApiRemote;

  ///
  static IV generateRandomIV() {
    final iv = CryptoApi.generateRandomIV();
    return iv;
  }

  ///
  static Key generateRandomKey() {
    final key = CryptoApi.generateRandomKey();
    return key;
  }

  ///
  Future<void> connect(String userId) async {
    await _chatApiRemote.connect(userId);
  }
}
