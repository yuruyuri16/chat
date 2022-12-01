// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_chat_bloc.dart';

enum CreateChatStatus {
  initial,
  success;

  bool get isInitial => this == CreateChatStatus.initial;
  bool get isSuccess => this == CreateChatStatus.success;
}

class CreateChatState extends Equatable {
  const CreateChatState({
    this.status = CreateChatStatus.initial,
    this.key,
    this.iv,
  });

  final Key? key;
  final IV? iv;
  final CreateChatStatus status;

  @override
  List<Object?> get props => [status, key, iv];

  CreateChatState copyWith({
    Key? key,
    IV? iv,
    CreateChatStatus? status,
  }) {
    return CreateChatState(
      key: key ?? this.key,
      iv: iv ?? this.iv,
      status: status ?? this.status,
    );
  }
}
