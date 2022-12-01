// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == LoginStatus.initial;
  bool get isLoading => this == LoginStatus.loading;
  bool get isSuccess => this == LoginStatus.success;
  bool get isFailure => this == LoginStatus.failure;
}

class LoginState extends Equatable {
  const LoginState({
    this.phoneNumber = '',
    this.password = '',
    this.status = LoginStatus.initial,
  });

  final String phoneNumber;
  final String password;
  final LoginStatus status;

  @override
  List<Object> get props => [phoneNumber, password, status];

  LoginState copyWith({
    String? phoneNumber,
    String? password,
    LoginStatus? status,
  }) {
    return LoginState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
