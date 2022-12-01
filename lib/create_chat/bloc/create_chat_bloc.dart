import 'package:bloc/bloc.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:equatable/equatable.dart';

part 'create_chat_event.dart';
part 'create_chat_state.dart';

class CreateChatBloc extends Bloc<CreateChatEvent, CreateChatState> {
  CreateChatBloc(this._chatRepository) : super(const CreateChatState()) {
    on<CreateChatGenerateKey>(_onGenerateKey);
    on<CreateChatQrScanned>(_onQrScanned);
  }

  final ChatRepository _chatRepository;

  void _onGenerateKey(
    CreateChatGenerateKey event,
    Emitter<CreateChatState> emit,
  ) {
    final key = ChatRepository.generateRandomKey();
    emit(state.copyWith(status: CreateChatStatus.success, key: key));
  }

  Future<void> _onQrScanned(
    CreateChatQrScanned event,
    Emitter<CreateChatState> emit,
  ) async {}
}
