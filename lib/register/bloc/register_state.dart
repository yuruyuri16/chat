// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

enum RegisterStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == RegisterStatus.initial;
  bool get isLoading => this == RegisterStatus.loading;
  bool get isSuccess => this == RegisterStatus.success;
  bool get isFailure => this == RegisterStatus.failure;
}

class RegisterState extends Equatable {
  const RegisterState({
    this.name = '',
    this.phoneNumber = '',
    this.password = '',
    this.status = RegisterStatus.initial,
  });

  final String name;
  final String phoneNumber;
  final String password;
  final RegisterStatus status;

  @override
  List<Object> get props => [name, phoneNumber, password, status];

  RegisterState copyWith({
    String? name,
    String? phoneNumber,
    String? password,
    RegisterStatus? status,
  }) {
    return RegisterState(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
