// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'otp_code_bloc.dart';

enum OtpCodeStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == OtpCodeStatus.initial;
  bool get isLoading => this == OtpCodeStatus.loading;
  bool get isSuccess => this == OtpCodeStatus.success;
  bool get isFailure => this == OtpCodeStatus.failure;
}

class OtpCodeState extends Equatable {
  const OtpCodeState({this.code = '', this.status = OtpCodeStatus.initial});

  final String code;
  final OtpCodeStatus status;

  @override
  List<Object> get props => [code, status];

  OtpCodeState copyWith({
    String? code,
    OtpCodeStatus? status,
  }) {
    return OtpCodeState(
      code: code ?? this.code,
      status: status ?? this.status,
    );
  }
}
