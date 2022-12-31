import 'package:smarthome_algeria/src/features/devices/devices_feature.dart';
import 'package:smarthome_algeria/src/services/localDatabase/devicesTable/types.dart';
import 'package:smarthome_algeria/src/services/localDatabase/service.dart';
import 'package:smarthome_algeria/src/services/servicesProvider/service.dart';

class AddDeviceMessage extends ServiceMessage {
  final _serviceId = AppServices.localDatabase.index;
  final _taskId = DatabaseActions.insertDevice.index;
  late InsertDeviceData _data;

  AddDeviceMessage({required Device device, required VoidCallback callback})
      : super(
          voidCallback: callback,
          expectingVoidCallback: true,
        ) {
    _data = InsertDeviceData(
        device.homeId,
        device.roomId,
        device.id,
        device.name,
        device.type.index,
        device.type.index,
        device.powerConsumption);
  }

  @override
  ServiceMessageData getDataObject(int messageId) {
    return ServiceMessageData<InsertDeviceData>(_data,
        messageId: messageId, serviceId: _serviceId, taskId: _taskId);
  }
}

class UpdateDeviceMessage extends ServiceMessage {
  final _serviceId = AppServices.localDatabase.index;
  final _taskId = DatabaseActions.updateDevice.index;
  late UpdateDeviceData _data;

  UpdateDeviceMessage({required Device device, required VoidCallback callback})
      : super(
          voidCallback: callback,
          expectingVoidCallback: true,
        ) {
    _data = UpdateDeviceData(
        device.homeId,
        device.roomId,
        device.id,
        device.name,
        device.type.index,
        device.type.index,
        device.powerConsumption);
  }

  @override
  ServiceMessageData getDataObject(int messageId) {
    return ServiceMessageData<UpdateDeviceData>(_data,
        messageId: messageId, serviceId: _serviceId, taskId: _taskId);
  }
}

class DeleteDeviceMessage extends ServiceMessage {
  final _serviceId = AppServices.localDatabase.index;
  final _taskId = DatabaseActions.deleteDevice.index;
  late DeleteDeviceData _data;

  DeleteDeviceMessage({required Device device, required VoidCallback callback})
      : super(
          voidCallback: callback,
          expectingVoidCallback: true,
        ) {
    _data = DeleteDeviceData(
      device.homeId,
      device.roomId,
      device.id,
    );
  }

  @override
  ServiceMessageData getDataObject(int messageId) {
    return ServiceMessageData<DeleteDeviceData>(_data,
        messageId: messageId, serviceId: _serviceId, taskId: _taskId);
  }
}

class LoadAllDevicesMessage extends ServiceMessage<List<Device>> {
  final _serviceId = AppServices.localDatabase.index;
  final _taskId = DatabaseActions.selectDevice.index;

  late SelectDeviceData _data;

  LoadAllDevicesMessage(
      {required int homeId,
      required int roomId,
      required TypedCallback<List<Device>> callback})
      : super(
          callback: callback,
          expectingCallback: true,
        ) {
    _data = SelectDeviceData(homeId, roomId);
  }

  @override
  ServiceMessageData getDataObject(int messageId) {
    return ServiceMessageData<SelectDeviceData>(_data,
        messageId: messageId, serviceId: _serviceId, taskId: _taskId);
  }
}
