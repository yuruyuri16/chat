import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_api_remote/user_api_remote.dart';
import 'package:user_repository/user_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(this._userRepository)
      : super(
          _userRepository.user.isEmpty
              ? const AppState.unauthenticated()
              : AppState.authenticated(_userRepository.user),
        ) {
    on<AppStatusChanged>(_onUserStatusChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _subscription = _userRepository.authenticationStatus
        .listen((status) => add(AppStatusChanged(status)));
  }

  final UserRepository _userRepository;
  late final StreamSubscription<AuthenticationStatus> _subscription;

  void _onUserStatusChanged(AppStatusChanged event, Emitter<AppState> emit) {
    if (event.status == AuthenticationStatus.authenticated) {
      emit(AppState.authenticated(_userRepository.user));
    } else {
      emit(const AppState.unauthenticated());
    }
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    emit(const AppState.unauthenticated());
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
