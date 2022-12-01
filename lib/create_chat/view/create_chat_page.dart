import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:chat/app/app.dart';
import 'package:chat/create_chat/create_chat.dart';
import 'package:chat_repository/chat_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateChatPage extends StatelessWidget {
  const CreateChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateChatBloc(context.read<ChatRepository>())
        ..add(CreateChatGenerateKey()),
      child: const CreateChatView(),
    );
  }
}

class CreateChatView extends StatelessWidget {
  const CreateChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear chat')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _QrCode(),
              SizedBox(height: 16),
              _ScanButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _QrCode extends StatelessWidget {
  const _QrCode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateChatBloc, CreateChatState>(
      builder: (_, state) {
        if (state.status.isSuccess) {
          final data = {
            'key': state.key!.base64,
            'chatId': 0,
          };
          return QrImage(
            size: 256,
            data: jsonEncode(data),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _ScanButton extends StatelessWidget {
  const _ScanButton();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width / 2,
      child: ElevatedButton(
        onPressed: () async {
          final data = await context.pushRoute<Map<String, dynamic>>(
            const QrScannerRoute(),
          );
        },
        child: const Text('Escanear'),
      ),
    );
  }
}
