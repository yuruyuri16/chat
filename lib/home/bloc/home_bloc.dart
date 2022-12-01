import 'package:bloc/bloc.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._chatRepository, this._userRepository)
      : super(const HomeState()) {
    on<HomeConnectionRequested>(_onConnectionRequested);
  }

  final ChatRepository _chatRepository;
  final UserRepository _userRepository;

  Future<void> _onConnectionRequested(
    HomeConnectionRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      await _chatRepository.connect(_userRepository.user.userId);
      emit(state.copyWith(status: HomeStatus.success));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }
}
