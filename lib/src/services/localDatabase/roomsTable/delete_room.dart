
import 'package:smarthome_algeria/src/services/servicesProvider/types.dart';

import 'package:smarthome_algeria/src/services/localDatabase/types.dart' as app;

import 'package:sqlite3/sqlite3.dart';

import 'delegate.dart';


class DeleteRoom extends TaskDelegate<void, DeleteRoomData> {
  final Database _db;
  late ServiceMessageData<DeleteRoomData> _messageData;

  DeleteRoom(this._db);

  @override
  Future<ServiceResponse<void>> execute() async{
   ServiceResponse<void> response;
    try {
     _deleteRoom();

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
  Future<void> setTaskData(ServiceMessageData<DeleteRoomData> message) async{
    _messageData = message;
  }
  
  void _deleteRoom() {
    final room = _messageData.data as DeleteRoomData;

    final stmt = _db.prepare(
      '''
      DELETE FROM ${app.DatabaseTables.rooms.name}
      WHERE ${RoomsTableAttributes.homeId.name} = ?,
      AND ${RoomsTableAttributes.roomId.name} = ?
      ''');
      
    stmt.execute([room.homeId, room.roomId]);
    stmt.dispose();

    return ;
  }
  
  @override
  int get taskId => app.DatabaseActions.deleteRoom.index;
}

