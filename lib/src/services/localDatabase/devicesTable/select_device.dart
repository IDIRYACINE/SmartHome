import 'package:smarthome_algeria/src/features/devices/data/devices.dart';
import 'package:smarthome_algeria/src/services/localDatabase/devicesTable/delegate.dart';
import 'package:smarthome_algeria/src/services/localDatabase/types.dart' as app;
import 'package:smarthome_algeria/src/services/servicesProvider/types.dart';

import 'package:sqlite3/sqlite3.dart';

class SelectDevice extends TaskDelegate<List<Device>, SelectDeviceData> {
  final Database _db;
  late ServiceMessageData<SelectDeviceData> _messageData;

  SelectDevice(this._db);

  @override
  Future<ServiceResponse<List<Device>>> execute() async {
    ServiceResponse<List<Device>> response;
    try {
      List<Device> devices = _selectDevice();

      response = ServiceResponse(
        data: devices,
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
  Future<void> setTaskData(ServiceMessageData<SelectDeviceData> message) async {
    _messageData = message;
  }

  List<Device> _selectDevice() {
    final device = _messageData.data as SelectDeviceData;

    final stmt = _db.prepare('''
      SELECT * FROM ${app.DatabaseTables.devices.name}
      WHERE ${DevicesTableAttributes.homeId.name} = ?,
      AND ${DevicesTableAttributes.roomId.name} = ?
      ''');

    ResultSet result = stmt.select([device.homeId, device.roomId]);

    stmt.dispose();

    return [];
  }


  @override
  int get taskId => app.DatabaseActions.selectDevice.index;
}
