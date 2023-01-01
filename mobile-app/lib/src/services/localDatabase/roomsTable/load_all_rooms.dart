import 'package:smarthome_algeria/src/features/room/domain/room.dart';
import 'package:smarthome_algeria/src/services/localDatabase/devicesTable/delegate.dart';
import 'package:smarthome_algeria/src/services/localDatabase/repository/home_repository.dart';
import 'package:smarthome_algeria/src/services/servicesProvider/types.dart';

import 'package:smarthome_algeria/src/services/localDatabase/types.dart' as app;
import 'package:sqlite3/sqlite3.dart';

import 'delegate.dart';

class LoadAllRooms extends TaskDelegate<List<Room>, void> {
  final Database _db;
  late ServiceMessageData<void> _messageData;

  LoadAllRooms(this._db);

  @override
  Future<ServiceResponse<List<Room>>> execute() async {
    ServiceResponse<List<Room>> response;
    try {
      List<Room> rooms = _selectRooms();

      response = ServiceResponse(
        data: rooms,
        messageId: _messageData.messageId,
        status: OperationStatus.success,
      );
    } catch (e) {
      response = ServiceResponse(
        data: [],
        messageId: _messageData.messageId,
        status: OperationStatus.error,
      );
    }

    return response;
  }

  @override
  Future<void> setTaskData(ServiceMessageData<void> message) async {
    _messageData = message;
  }

  List<Room> _selectRooms() {
    List<Room> rooms = [];

    final roomsStmt = _db.prepare('''
      SELECT * FROM ${app.DatabaseTables.rooms.name}
      ''');

    final devicesStmt = _db.prepare('''
      SELECT * FROM ${app.DatabaseTables.devices.name} 
      WHERE ${DevicesTableAttributes.homeId.name} = ?
      AND ${DevicesTableAttributes.roomId.name} = ?
      ''');

    ResultSet roomsResultSet = roomsStmt.select();
    ResultSet devicesResultSet;

    for (Row row in roomsResultSet) {
      int homeId = row[RoomsTableAttributes.homeId.name];
      int roomId = row[RoomsTableAttributes.roomId.name];
      devicesResultSet = devicesStmt.select([homeId, roomId]);

      Room room = resultSetToRoom(row, devicesResultSet);
      rooms.add(room);

      devicesStmt.dispose();
    }

    roomsStmt.dispose();

    return rooms;
  }

  @override
  int get taskId => app.DatabaseActions.selectHome.index;
}
