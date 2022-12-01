import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'otp_code_event.dart';
part 'otp_code_state.dart';

class OtpCodeBloc extends Bloc<OtpCodeEvent, OtpCodeState> {
  OtpCodeBloc(this._userRepository, this.phoneNumber)
      : super(const OtpCodeState()) {
    on<OtpCodeCodeChanged>(_onCodeChanged);
    on<OtpCodeSubmitButtonPressed>(_onSubmitPressed);
  }

  final String phoneNumber;
  final UserRepository _userRepository;

  void _onCodeChanged(OtpCodeCodeChanged event, Emitter<OtpCodeState> emit) {
    emit(state.copyWith(code: event.code));
  }

  Future<void> _onSubmitPressed(
    OtpCodeSubmitButtonPressed event,
    Emitter<OtpCodeState> emit,
  ) async {
    emit(state.copyWith(status: OtpCodeStatus.loading));
    try {
      await _userRepository.submitOtpCode(phoneNumber, state.code);
      emit(state.copyWith(status: OtpCodeStatus.success));
    } catch (e) {
      emit(state.copyWith(status: OtpCodeStatus.failure));
    }
  }
}
