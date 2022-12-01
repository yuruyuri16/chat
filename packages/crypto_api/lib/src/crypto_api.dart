/// {@template crypto_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
import 'package:encrypt/encrypt.dart';

/// {@template crypto_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class CryptoApi {
  /// {@macro crypto_api}
  const CryptoApi._();

  ///
  static Encrypted encrypt(String text, Key key, IV iv) {
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted;
  }

  /// Decrypt [ciphertext] with [Key] and [IV]
  static String decrypt(String ciphertext, Key key, IV iv) {
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final decrypted = encrypter.decrypt64(ciphertext, iv: iv);
    return decrypted;
  }

  /// Generate a random key
  static Key generateRandomKey() {
    final key = Key.fromSecureRandom(32);
    return key;
  }

  /// Generate a random initial vector
  static IV generateRandomIV() {
    final iv = IV.fromSecureRandom(16);
    return iv;
  }
}
