import 'dart:io';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

Future<void> main() async {
  print('init');
  final client =
      MqttServerClient.withPort('mosquito-stracontech.clicker.pe', '', 9001)
        // ..logging(on: true)
        ..secure = true;

  try {
    final status = await client.connect('jonathan.prieto', 'Enero2022');
    print('status: $status');
  } catch (e) {
    client.disconnect();
  }

  if (client.connectionStatus!.state == MqttConnectionState.connected) {
    print('EXAMPLE::Mosquitto client connected');
  } else {
    /// Use status here rather than state if you also want the broker return code.
    print(
        'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
    client.disconnect();
    exit(-1);
  }

  client.subscribe('test/lol', MqttQos.atMostOnce);

  client.updates?.listen((event) {
    print('EVENT');
    print(event);
  });

  client.published?.listen((event) {});
}
