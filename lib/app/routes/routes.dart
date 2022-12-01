import 'package:auto_route/auto_route.dart';
import 'package:chat/chat/chat.dart';
import 'package:chat/counter/counter.dart';
import 'package:chat/create_chat/create_chat.dart';
import 'package:chat/home/view/home_page.dart';
import 'package:chat/login/login.dart';
import 'package:chat/qr_scanner/qr_scanner.dart';
import 'package:chat/register/register.dart';
import 'package:chat/welcome/welcome.dart';
import 'package:flutter/material.dart';

part 'routes.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: WelcomePage, initial: true),
    AutoRoute(page: OtpCodePage),
    AutoRoute(page: CounterPage),
    AutoRoute(page: LoginPage),
    AutoRoute(page: RegisterPage),
    AutoRoute(page: HomePage),
    AutoRoute(page: ChatPage, path: '/chat/:id'),
    AutoRoute(page: CreateChatPage),
    AutoRoute<Map<String, dynamic>>(page: QrScannerPage),
  ],
)
class AppRouter extends _$AppRouter {}
