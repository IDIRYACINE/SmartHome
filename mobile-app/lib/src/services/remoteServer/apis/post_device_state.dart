
import 'package:flutter/services.dart';
import 'package:smarthome_algeria/src/services/remoteServer/utility/mqtt_wrapper.dart';
import 'package:smarthome_algeria/src/services/servicesProvider/service.dart';
import 'package:typed_data/typed_data.dart';

import '../types.dart';

class PostDeviceState extends TaskDelegate<void, DeviceData> {
  late ServiceMessageData<DeviceData> _messageData;

  final MQTTClientWrapper _mqttClientWrapper;

  PostDeviceState(this._mqttClientWrapper);

  @override
  Future<ServiceResponse> execute() async {
    ServiceResponse<void> response;
    try {
      final buffer = ByteData(12);
      buffer.setInt32(0, _messageData.data!.deviceId);
      buffer.setInt32(4, _messageData.data!.deviceType);
      buffer.setInt32(8, _messageData.data!.turnedOn ? 1 : 0);

      final payload = buffer.buffer.asUint8List();

      final bMessage = Uint8Buffer(12);
      bMessage.setAll(0, payload);

      _mqttClientWrapper.publishByteMessage(bMessage);

      response = ServiceResponse(
        data: null,
        messageId: _messageData.messageId,
        status: OperationStatus.success,
      );
    } catch (e) {
      response = ServiceResponse(
        data: null,
        messageId: _messageData.messageId,
        status: OperationStatus.error,
      );
    }

    return response;
  }

  @override
  Future<void> setTaskData(ServiceMessageData<DeviceData> message) async {
    _messageData = message;
  }

  @override
  int get taskId => ApiTasks.postDeviceState.index;
}
