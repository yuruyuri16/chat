part of 'create_chat_bloc.dart';

abstract class CreateChatEvent extends Equatable {
  const CreateChatEvent();

  @override
  List<Object> get props => [];
}

class CreateChatGenerateKey extends CreateChatEvent {}

class CreateChatQrScanned extends CreateChatEvent {}
