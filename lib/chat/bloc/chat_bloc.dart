import 'package:bloc/bloc.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this._chatRepository) : super(const ChatState()) {
    on<ChatSendButtonPressed>(_onSendButtonPressed);
  }

  final ChatRepository _chatRepository;

  Future<void> _onSendButtonPressed(
    ChatSendButtonPressed event,
    Emitter<ChatState> emit,
  ) async {
    try {} catch (e) {
      throw Exception(e);
    }
  }
}
