part of 'otp_code_bloc.dart';

abstract class OtpCodeEvent extends Equatable {
  const OtpCodeEvent();

  @override
  List<Object> get props => [];
}

class OtpCodeCodeChanged extends OtpCodeEvent {
  const OtpCodeCodeChanged(this.code);

  final String code;
}

class OtpCodeSubmitButtonPressed extends OtpCodeEvent {}
