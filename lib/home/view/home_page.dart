import 'package:auto_route/auto_route.dart';
import 'package:chat/app/app.dart';
import 'package:chat/home/home.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => HomeBloc(
        context.read<ChatRepository>(),
        context.read<UserRepository>(),
      )..add(HomeConnectionRequested()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    print(context.read<UserRepository>().user.userId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          IconButton(
            onPressed: () => context.pushRoute(const CreateChatRoute()),
            icon: const Icon(Icons.chat),
          ),
        ],
      ),
      body: ListView(
        children: [
          ChatTile(
            chatId: '12',
            name: 'Name',
            lastMessage: 'lm',
            onTap: () => context.pushRoute(
              ChatRoute(
                chatId: '12',
                name: 'Jonathan Prieto',
              ),
            ),
          ),
          ChatTile(
            chatId: '13',
            name: 'Name',
            lastMessage: 'lm',
            onTap: () {},
          ),
          ChatTile(
            chatId: '14',
            name: 'Name',
            lastMessage: 'lm',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
