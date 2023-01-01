import 'package:smarthome_algeria/src/services/localDatabase/devicesTable/delegate.dart';
import 'package:smarthome_algeria/src/services/localDatabase/types.dart' as app;
import 'package:smarthome_algeria/src/services/servicesProvider/types.dart';

import 'package:sqlite3/sqlite3.dart';

class InsertDevice extends TaskDelegate<void, InsertDeviceData> {
  final Database _db;
  late ServiceMessageData<InsertDeviceData> _messageData;

  InsertDevice(this._db);

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
  Future<void> setTaskData(ServiceMessageData<InsertDeviceData> message) async {
    _messageData = message;
  }

  void _insertDevice() {
    final device = _messageData.data as InsertDeviceData;

    final stmt = _db.prepare('''
      INSERT INTO ${app.DatabaseTables.devices.name}
      (
        ${DevicesTableAttributes.homeId.name},
        ${DevicesTableAttributes.roomId.name},
        ${DevicesTableAttributes.deviceId.name},
        ${DevicesTableAttributes.deviceType.name},
        ${DevicesTableAttributes.deviceSubtype.name},
        ${DevicesTableAttributes.deviceConsumption.name},
        ${DevicesTableAttributes.deviceName.name}
      )
      VALUES (?, ?, ?, ?, ?, ?, ?)
      ''');

    stmt.execute([
      device.homeId,
      device.roomId,
      device.deviceId,
      device.deviceType,
      device.deviceSubtype,
      device.deviceConsumption,
      device.deviceName
    ]);
    
    stmt.dispose();

    return;
  }


  @override
  int get taskId => app.DatabaseActions.insertDevice.index;
}
