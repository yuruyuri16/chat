// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'routes.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    WelcomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const WelcomePage(),
      );
    },
    OtpCodeRoute.name: (routeData) {
      final args = routeData.argsAs<OtpCodeRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: OtpCodePage(
          key: args.key,
          phoneNumber: args.phoneNumber,
        ),
      );
    },
    CounterRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const CounterPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const RegisterPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    ChatRoute.name: (routeData) {
      final args = routeData.argsAs<ChatRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: ChatPage(
          key: args.key,
          chatId: args.chatId,
          name: args.name,
        ),
      );
    },
    CreateChatRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const CreateChatPage(),
      );
    },
    QrScannerRoute.name: (routeData) {
      return MaterialPageX<Map<String, dynamic>>(
        routeData: routeData,
        child: const QrScannerPage(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          WelcomeRoute.name,
          path: '/',
        ),
        RouteConfig(
          OtpCodeRoute.name,
          path: '/otp-code-page',
        ),
        RouteConfig(
          CounterRoute.name,
          path: '/counter-page',
        ),
        RouteConfig(
          LoginRoute.name,
          path: '/login-page',
        ),
        RouteConfig(
          RegisterRoute.name,
          path: '/register-page',
        ),
        RouteConfig(
          HomeRoute.name,
          path: '/home-page',
        ),
        RouteConfig(
          ChatRoute.name,
          path: '/chat/:id',
        ),
        RouteConfig(
          CreateChatRoute.name,
          path: '/create-chat-page',
        ),
        RouteConfig(
          QrScannerRoute.name,
          path: '/qr-scanner-page',
        ),
      ];
}

/// generated route for
/// [WelcomePage]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute()
      : super(
          WelcomeRoute.name,
          path: '/',
        );

  static const String name = 'WelcomeRoute';
}

/// generated route for
/// [OtpCodePage]
class OtpCodeRoute extends PageRouteInfo<OtpCodeRouteArgs> {
  OtpCodeRoute({
    Key? key,
    required String phoneNumber,
  }) : super(
          OtpCodeRoute.name,
          path: '/otp-code-page',
          args: OtpCodeRouteArgs(
            key: key,
            phoneNumber: phoneNumber,
          ),
        );

  static const String name = 'OtpCodeRoute';
}

class OtpCodeRouteArgs {
  const OtpCodeRouteArgs({
    this.key,
    required this.phoneNumber,
  });

  final Key? key;

  final String phoneNumber;

  @override
  String toString() {
    return 'OtpCodeRouteArgs{key: $key, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [CounterPage]
class CounterRoute extends PageRouteInfo<void> {
  const CounterRoute()
      : super(
          CounterRoute.name,
          path: '/counter-page',
        );

  static const String name = 'CounterRoute';
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login-page',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/register-page',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home-page',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [ChatPage]
class ChatRoute extends PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    Key? key,
    required String chatId,
    required String name,
  }) : super(
          ChatRoute.name,
          path: '/chat/:id',
          args: ChatRouteArgs(
            key: key,
            chatId: chatId,
            name: name,
          ),
          rawPathParams: {'id': chatId},
        );

  static const String name = 'ChatRoute';
}

class ChatRouteArgs {
  const ChatRouteArgs({
    this.key,
    required this.chatId,
    required this.name,
  });

  final Key? key;

  final String chatId;

  final String name;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, chatId: $chatId, name: $name}';
  }
}

/// generated route for
/// [CreateChatPage]
class CreateChatRoute extends PageRouteInfo<void> {
  const CreateChatRoute()
      : super(
          CreateChatRoute.name,
          path: '/create-chat-page',
        );

  static const String name = 'CreateChatRoute';
}

/// generated route for
/// [QrScannerPage]
class QrScannerRoute extends PageRouteInfo<void> {
  const QrScannerRoute()
      : super(
          QrScannerRoute.name,
          path: '/qr-scanner-page',
        );

  static const String name = 'QrScannerRoute';
}
