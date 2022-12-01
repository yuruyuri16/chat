import 'package:auto_route/auto_route.dart';
import 'package:chat/chat/chat.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    super.key,
    @PathParam('id') required this.chatId,
    required this.name,
  });

  final String chatId;
  final String name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatBloc(context.read<ChatRepository>()),
      child: ChatView(name: name),
    );
  }
}

class ChatView extends StatelessWidget {
  ChatView({super.key, required this.name});

  final String name;
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Chat(
        messages: _messages,
        user: _user,
        onSendPressed: (value) {},
        l10n: const ChatL10nEs(),
      ),
    );
  }
}

// class _Messages extends StatelessWidget {
//   const _Messages();

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [],
//     );
//   }
// }

// class _MessageField extends StatelessWidget {
//   const _MessageField();

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       onChanged: (value) {},
//     );
//   }
// }
