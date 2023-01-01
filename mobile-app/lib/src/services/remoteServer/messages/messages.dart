import 'package:smarthome_algeria/src/features/devices/devices_feature.dart';
import 'package:smarthome_algeria/src/services/remoteServer/types.dart';
import 'package:smarthome_algeria/src/services/servicesProvider/service.dart';

class PostDeviceStateMessage extends ServiceMessage {
  final _serviceId = AppServices.localDatabase.index;
  final _taskId = ApiTasks.postDeviceState.index;

  late DeviceData _data;

  PostDeviceStateMessage(
    Device device,
    bool isOn,
  ) : super() {
    _data = DeviceData(
        deviceId: device.id,
        deviceType: device.type.index,
        turnedOn: isOn ? 1 : 0);
  }

  @override
  ServiceMessageData getDataObject(int messageId) {
    return ServiceMessageData<DeviceData>(_data,
        messageId: messageId, serviceId: _serviceId, taskId: _taskId);
  }
}
