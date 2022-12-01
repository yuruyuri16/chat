import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

/// {@template chat_api_remote}
/// Remote chat API
/// {@endtemplate}
class ChatApiRemote {
  /// {@macro chat_api_remote}
  ChatApiRemote(
    String server,
    int port,
    String username,
    String password,
  )   : client = MqttServerClient.withPort(server, 'yuri', port)
          ..logging(on: true)
          ..keepAlivePeriod = 3,
        _username = username,
        _password = password;

  ///
  final MqttServerClient client;

  ///
  final String _username;

  ///
  final String _password;

  ///
  Stream<List<MqttReceivedMessage<MqttMessage>>> get messages =>
      client.updates!;

  ///
  Future<void> connect(String userId) async {
    try {
      await client.connect(_username, _password);
      client.subscribe(
        'mensaje/chat/+/usuario/desde/+/hasta/$userId',
        MqttQos.atLeastOnce,
      );
      client.updates?.listen((event) {
        print('----------EVENT-------');
        final mes = event[0].payload as MqttPublishMessage;
        final res =
            MqttPublishPayload.bytesToStringAsString(mes.payload.message);
        print(res);
        print('---------EVENT FINISHED------');
      });
    } catch (e) {
      client.disconnect();
    }
  }

  ///
  Future<void> sendMessage(
    String fromUserId,
    String toUserId,
    String chatId,
  ) async {
    final builder = MqttClientPayloadBuilder()..addString('');
    client
      ..subscribe(
        'mensaje/chat/$chatId/usuario/desde/$fromUserId/hasta/$toUserId',
        MqttQos.atLeastOnce,
      )
      ..publishMessage(
        'mensaje/chat/$chatId/usuario/desde/$fromUserId/hasta/$toUserId',
        MqttQos.atLeastOnce,
        builder.payload!,
      );
  }

  ///
  Future<void> disconnect() async {
    client.disconnect();
  }
}
