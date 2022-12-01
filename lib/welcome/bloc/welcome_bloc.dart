import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc(this._userRepository) : super(const WelcomeState()) {
    on<WelcomePhoneNumberChanged>(_onPhoneNumberChanged);
    on<WelcomeSubmitButtonPressed>(_onSubmitButtonPressed);
  }

  final UserRepository _userRepository;

  void _onPhoneNumberChanged(
    WelcomePhoneNumberChanged event,
    Emitter<WelcomeState> emit,
  ) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  Future<void> _onSubmitButtonPressed(
    WelcomeSubmitButtonPressed event,
    Emitter<WelcomeState> emit,
  ) async {
    emit(state.copyWith(status: WelcomeStatus.loading));
    try {
      final isNewUser = await _userRepository.requestOtpCode(state.phoneNumber);
      emit(state.copyWith(status: WelcomeStatus.success, isNewUser: isNewUser));
    } catch (e) {
      emit(state.copyWith(status: WelcomeStatus.failure));
    }
  }
}
