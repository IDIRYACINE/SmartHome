import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:smarthome_algeria/src/services/remoteServer/types.dart';
import 'package:smarthome_algeria/src/services/remoteServer/utility/mqtt_wrapper.dart';
import 'package:typed_data/typed_buffers.dart';

void main() {
  test("encoders", () {

    DeviceData data = DeviceData(
      deviceId: 1,
      deviceType: 1,
      turnedOn: 1,
    );

    final buffer = ByteData(12);
    buffer.setInt32(0, data.deviceId);
    buffer.setInt32(4, data.deviceType);
    buffer.setInt32(8, data.turnedOn);

    final payload = buffer.buffer.asUint8List();

    final bMessage = Uint8Buffer(12);
    bMessage.setAll(0, payload);

  });

  test("Mqtt", () async {
    DeviceData data = DeviceData(
      deviceId: 1,
      deviceType: 1,
      turnedOn: 1,
    );

    final buffer = ByteData(12);
    buffer.setInt32(0, data.deviceId);
    buffer.setInt32(4, data.deviceType);
    buffer.setInt32(8, data.turnedOn);

    final payload = buffer.buffer.asUint8List();

    final bMessage = Uint8Buffer(12);
    bMessage.setAll(0, payload);

    MQTTClientWrapper client = MQTTClientWrapper();
    client.prepareMqttClient().then((value) {
      client.publishByteMessage(bMessage);
    });
  });
}
