// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'welcome_bloc.dart';

enum WelcomeStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == WelcomeStatus.initial;
  bool get isLoading => this == WelcomeStatus.loading;
  bool get isSuccess => this == WelcomeStatus.success;
  bool get isFailure => this == WelcomeStatus.failure;
}

class WelcomeState extends Equatable {
  const WelcomeState({
    this.phoneNumber = '',
    this.status = WelcomeStatus.initial,
    this.isNewUser = true,
  });

  final String phoneNumber;
  final WelcomeStatus status;
  final bool isNewUser;

  @override
  List<Object> get props => [phoneNumber, status];

  WelcomeState copyWith({
    String? phoneNumber,
    WelcomeStatus? status,
    bool? isNewUser,
  }) {
    return WelcomeState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      isNewUser: isNewUser ?? this.isNewUser,
    );
  }
}
