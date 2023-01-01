import 'package:smarthome_algeria/src/services/localDatabase/types.dart' as app;
import 'package:smarthome_algeria/src/services/servicesProvider/types.dart';

import 'package:sqlite3/sqlite3.dart';

import 'delegate.dart';

class InsertRoom extends TaskDelegate<void, InsertRoomData> {
  final Database _db;
  late ServiceMessageData<InsertRoomData> _messageData;

  InsertRoom(this._db);

  @override
  Future<ServiceResponse<void>> execute() async {
    ServiceResponse<void> response;
    try {
      _insertRoom();

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
  Future<void> setTaskData(ServiceMessageData<InsertRoomData> message) async {
    _messageData = message;
  }

  void _insertRoom() {
    final room = _messageData.data as InsertRoomData;

    final stmt = _db.prepare('''
      INSERT INTO ${app.DatabaseTables.rooms.name}
      (${RoomsTableAttributes.homeId.name}, ${RoomsTableAttributes.roomId.name},${RoomsTableAttributes.roomName.name})
      VALUES (?, ?,?)
      ''');

    stmt.execute([room.homeId, room.roomId, room.roomName]);
    stmt.dispose();

    return;
  }

  @override
  int get taskId => app.DatabaseActions.insertRoom.index;
}
