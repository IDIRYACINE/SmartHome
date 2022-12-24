


import 'package:smarthome_algeria/src/services/localDatabase/devicesTable/delegate.dart';
import 'package:smarthome_algeria/src/services/localDatabase/types.dart' as app;
import 'package:smarthome_algeria/src/services/servicesProvider/types.dart';


import 'package:sqlite3/sqlite3.dart';



class DeleteDevice extends TaskDelegate<void, DeleteDeviceData> {
  final Database _db;
  late ServiceMessageData<DeleteDeviceData> _messageData;

  DeleteDevice(this._db);

  @override
  Future<ServiceResponse<void>> execute() async{
   ServiceResponse<void> response;
    try {
     _deleteDevice();

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
  Future<void> setTaskData(ServiceMessageData<DeleteDeviceData> message) async{
    _messageData = message;
  }
  
  void _deleteDevice() {
    final device = _messageData.data as DeleteDeviceData;

    final stmt = _db.prepare(
      '''
      DELETE FROM ${app.DatabaseTables.devices.name}
      WHERE ${DevicesTableAttributes.homeId.name} = ?,
      AND ${DevicesTableAttributes.roomId.name} = ?,
      AND ${DevicesTableAttributes.deviceId.name} = ?
      ''');
      
    stmt.execute([device.homeId, device.roomId,device.deviceId]);
    stmt.dispose();

    return ;
  }

  @override
  int get taskId => app.DatabaseActions.deleteDevice.index;
}

