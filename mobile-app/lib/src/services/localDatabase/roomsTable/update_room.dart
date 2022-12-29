
import 'package:smarthome_algeria/src/services/servicesProvider/types.dart';

import 'package:smarthome_algeria/src/services/localDatabase/types.dart' as app;

import 'package:smarthome_algeria/src/features/home/domain/home.dart';
import 'package:sqlite3/sqlite3.dart';

import 'delegate.dart';


class UpdateRoom extends TaskDelegate<void, int> {
  final Database _db;
  late ServiceMessageData _messageData;

  UpdateRoom(this._db);

  @override
  Future<ServiceResponse<void>> execute() async{
   ServiceResponse<void> response;
    try {
     _updateRoom();

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
  Future<void> setTaskData(ServiceMessageData<int> message) async{
    _messageData = message;
  }
  
  void _updateRoom() {
    final home = _messageData.data as Home;

    final stmt = _db.prepare(
      '''
      DELETE FROM ${app.DatabaseTables.rooms.name}
      WHERE ${RoomsTableAttributes.homeId.name} = ?
      ''');
      
    stmt.execute([home.id]);
    stmt.dispose();

    return ;
  }
  @override
  int get taskId => app.DatabaseActions.updateRoom.index;
}

