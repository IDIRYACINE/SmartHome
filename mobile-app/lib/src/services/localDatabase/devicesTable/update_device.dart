import 'package:smarthome_algeria/src/services/localDatabase/devicesTable/delegate.dart';
import 'package:smarthome_algeria/src/services/localDatabase/types.dart' as app;
import 'package:smarthome_algeria/src/services/servicesProvider/types.dart';

import 'package:sqlite3/sqlite3.dart';

class UpdateDevice extends TaskDelegate<void, UpdateDeviceData> {
  final Database _db;
  late ServiceMessageData<UpdateDeviceData> _messageData;

  UpdateDevice(this._db);

  @override
  Future<ServiceResponse<void>> execute() async {
    ServiceResponse<void> response;
    try {
      _insertDevice();

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
  Future<void> setTaskData(ServiceMessageData<UpdateDeviceData> message) async {
    _messageData = message;
  }

  void _insertDevice() {
    final device = _messageData.data as UpdateDeviceData;

    final stmt = _db.prepare('''
      UPDATE ${app.DatabaseTables.devices.name}
      SET
        ${DevicesTableAttributes.deviceType.name} = ?,
        ${DevicesTableAttributes.deviceSubtype.name} = ?,
        ${DevicesTableAttributes.deviceConsumption.name} = ?,
        ${DevicesTableAttributes.deviceName.name} = ?
      WHERE 
      ${DevicesTableAttributes.homeId.name} = ?
      AND ${DevicesTableAttributes.roomId.name} = ?
      AND ${DevicesTableAttributes.deviceId.name} = ?
      ''');

    stmt.execute([
      device.deviceType,
      device.deviceSubtype,
      device.deviceConsumption,
      device.deviceName,
      device.homeId,
      device.roomId,
      device.deviceId,
    ]);
    
    stmt.dispose();

    return;
  }


  @override
  int get taskId => app.DatabaseActions.updateDevice.index;
}
