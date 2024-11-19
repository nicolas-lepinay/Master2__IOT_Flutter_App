import 'dart:io';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

@lazySingleton
class MQTT {
  late final MqttServerClient mqttClient;

  MQTT() {
    _init();
  }

  void _init() {
    mqttClient = MqttServerClient.withPort(
        'b5f2bf8397624117be2142697084afa1.s1.eu.hivemq.cloud', '', 8883);
    mqttClient.secure = true; // Utiliser une connexion sécurisée
    mqttClient.logging(on: true);
    mqttClient.keepAlivePeriod = 20;
    mqttClient.securityContext = SecurityContext.defaultContext;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier('flutter_client')
        .authenticateAs('nicolas', 'Abcd1234')
        .startClean()
        .withWillQos(MqttQos.atMostOnce);

    mqttClient.connectionMessage = connMess;

    mqttClient.connect().then((value) {
      if (mqttClient.connectionStatus!.state == MqttConnectionState.connected) {
        debugPrint('MQTT client connected successfully');
        // S'abonner aux topics
        mqttClient.subscribe('equipments/+/status', MqttQos.atLeastOnce);

        mqttClient.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
          final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
          final payload =
              MqttPublishPayload.bytesToStringAsString(message.payload.message);
          debugPrint('Received message: $payload from topic: ${c[0].topic}');
          // Vous pouvez mettre à jour l'état des équipements ici
        });
      } else {
        debugPrint('MQTT client connection failed');
      }
    }).catchError((e) {
      debugPrint('MQTT client connection error: $e');
    });
  }
}
