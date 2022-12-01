part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated;

  bool get isAuthenticated => this == AppStatus.authenticated;
  bool get isUnauthenticated => this == AppStatus.unauthenticated;
}

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty,
  });

  const AppState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final User user;
  final AppStatus status;

  @override
  List<Object> get props => [user, status];
}
