// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:typed_data/typed_buffers.dart';

class MQTTClientWrapper {
  late MqttServerClient client;

  final String _devicesStatetopic = 'Dart/Mqtt_client/devicesState';
  final String _devicesResponsesTopic = 'Dart/Mqtt_client/devicesResponses';

  MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.IDLE;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;

  // using async tasks, so the connection won't hinder the code flow
  Future<MqttCurrentConnectionState> prepareMqttClient() async {
    _setupMqttClient();
    return connectClient();
  }

  // waiting for the connection, if an error occurs, print it and disconnect
  Future<MqttCurrentConnectionState> connectClient() async {
    try {
      connectionState = MqttCurrentConnectionState.CONNECTING;
      await client.connect('idiryacine', 'idiryacine34');
      connectionState = MqttCurrentConnectionState.CONNECTED;
    } on Exception {
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }
    return connectionState;
  }

  void _setupMqttClient() {
    client = MqttServerClient.withPort(
        '0cd5c4fc8a9d45468efdcc59f176a76d.s2.eu.hivemq.cloud',
        'idiryacine',
        8883);
    client.secure = true;
    client.securityContext = SecurityContext.defaultContext;
    client.keepAlivePeriod = 20;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;
  }

  void _subscribeToTopic(String topicName) {
    client.subscribe(_devicesResponsesTopic, MqttQos.atMostOnce);

    // print the message when it is received
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      // final MqttMessage recMess = c[0].payload;
    });
  }

  void _publishMessage(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);

    client.publishMessage(
        _devicesStatetopic, MqttQos.exactlyOnce, builder.payload!);
  }

  void publishByteMessage(Uint8Buffer message) {
    client.publishMessage(_devicesStatetopic, MqttQos.exactlyOnce, message);
  }

  // callbacks for different events
  void _onSubscribed(String topic) {
    subscriptionState = MqttSubscriptionState.SUBSCRIBED;
  }

  void _onDisconnected() {
    connectionState = MqttCurrentConnectionState.DISCONNECTED;
  }

  void _onConnected() {
    connectionState = MqttCurrentConnectionState.CONNECTED;
    _subscribeToTopic(_devicesStatetopic);
    _publishMessage('Hello');
  }
}

enum MqttCurrentConnectionState {
  IDLE,
  CONNECTING,
  CONNECTED,
  DISCONNECTED,
  ERROR_WHEN_CONNECTING
}

enum MqttSubscriptionState { IDLE, SUBSCRIBED }
