/// {@template user}
/// User model
/// {@endtemplate}
class User {
  /// {@macro user}
  User({required this.userId, required this.name, required this.phoneNumber});

  ///
  final String userId;

  ///
  final String name;

  ///
  final String phoneNumber;

  ///
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }
}
