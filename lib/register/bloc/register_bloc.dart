import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this._userRepository) : super(const RegisterState()) {
    on<RegisterNameChanged>(_onNameChanged);
    on<RegisterPhoneNumberChanged>(_onPhoneNumberChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterSubmitButtonPressed>(_onSubmitButtonPressed);
  }

  final UserRepository _userRepository;

  void _onNameChanged(
    RegisterNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  void _onPhoneNumberChanged(
    RegisterPhoneNumberChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onSubmitButtonPressed(
    RegisterSubmitButtonPressed event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(status: RegisterStatus.loading));
    try {
      await _userRepository.register(
        state.name,
        state.phoneNumber,
        state.password,
      );
      emit(state.copyWith(status: RegisterStatus.success));
    } catch (e) {
      emit(state.copyWith(status: RegisterStatus.failure));
    }
  }
}
