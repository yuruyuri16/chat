// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/// {@template user}
/// User model
/// {@endtemplate}
class User {
  /// {@macro user}
  const User({this.fullName = '', this.phoneNumber = '', this.userId = ''});

  ///
  final String fullName;

  ///
  final String phoneNumber;

  ///
  final String userId;

  ///
  static const empty = User();

  ///
  bool get isEmpty => this == empty;

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      fullName: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      userId: map['userId'] as String,
    );
  }

  factory User.fromJson(String source) => source.isEmpty
      ? User.empty
      : User.fromMap(json.decode(source) as Map<String, dynamic>);
}
