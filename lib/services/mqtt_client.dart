import 'dart:io';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'package:arduino_iot_app/utils/settings.dart';

@lazySingleton
class MQTT {
  late final MqttServerClient mqttClient;

  MQTT() {
    _init();
  }

  void _init() {
    mqttClient =
        MqttServerClient.withPort(Settings.MQTT_HOST, '', Settings.MQTT_PORT);
    mqttClient.secure = true; // Utiliser une connexion sécurisée
    mqttClient.logging(on: true);
    mqttClient.keepAlivePeriod = 20;
    mqttClient.securityContext = SecurityContext.defaultContext;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier('Flutter_IOT_APP')
        .authenticateAs(Settings.MQTT_USERNAME, Settings.MQTT_PASSWORD)
        .startClean()
        .withWillQos(MqttQos.atMostOnce);

    mqttClient.connectionMessage = connMess;

    mqttClient.connect().then((value) {
      if (mqttClient.connectionStatus!.state == MqttConnectionState.connected) {
        debugPrint('MQTT client connected successfully');
        // S'abonner aux topics
        mqttClient.subscribe('KEVIN/+/state', MqttQos.atLeastOnce);
        mqttClient.subscribe('KEVIN/+/value', MqttQos.atLeastOnce);

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
