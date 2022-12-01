part of 'welcome_bloc.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();

  @override
  List<Object> get props => [];
}

class WelcomePhoneNumberChanged extends WelcomeEvent {
  const WelcomePhoneNumberChanged(this.phoneNumber);

  final String phoneNumber;
}

class WelcomeSubmitButtonPressed extends WelcomeEvent {}
