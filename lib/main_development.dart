import 'package:chat/app/app.dart';
import 'package:chat/bootstrap.dart';
import 'package:chat_api_remote/chat_api_remote.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:user_api_local/user_api_local.dart';
import 'package:user_api_remote/user_api_remote.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  bootstrap(() async {
    await dotenv.load();
    final baseUrl = dotenv.get('BASE_URL');

    final mqttServer = dotenv.get('MQTT_SERVER');
    final mqttPort = int.parse(dotenv.get('MQTT_PORT'));
    final mqttusername = dotenv.get('MQTT_USERNAME');
    final mqttPassword = dotenv.get('MQTT_PASSWORD');

    final pref = await SharedPreferences.getInstance();

    final httpClient = Dio(BaseOptions(baseUrl: baseUrl));

    final userApiRemote = UserApiRemote(httpClient: httpClient, pref: pref);
    final userApiLocal = UserApiLocal();
    final chatApiRemote = ChatApiRemote(
      mqttServer,
      mqttPort,
      mqttusername,
      mqttPassword,
    );

    await userApiLocal.init();

    final userRepository = UserRepository(
      userApiRemote: userApiRemote,
      userApiLocal: userApiLocal,
    );

    final chatRepository = ChatRepository(chatApiRemote: chatApiRemote);
    return App(
      userRepository: userRepository,
      chatRepository: chatRepository,
    );
  });
}
