
import 'package:smarthome_algeria/src/features/room/domain/room.dart';
import 'package:smarthome_algeria/src/services/servicesProvider/types.dart';


import 'package:smarthome_algeria/src/services/localDatabase/types.dart' as app;
import 'package:sqlite3/sqlite3.dart';

import 'delegate.dart';


class SelectRoom extends TaskDelegate<List<Room>, SelecRoomData> {
  final Database _db;
  late ServiceMessageData<SelecRoomData> _messageData;

  SelectRoom(this._db);

  @override
  Future<ServiceResponse<List<Room>>> execute() async{
   ServiceResponse<List<Room>> response;
    try {
      List<Room> rooms  = _selectRooms();

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
  Future<void> setTaskData(ServiceMessageData<SelecRoomData> message) async{
    _messageData = message;
  }
  
  List<Room> _selectRooms() {
    final room = _messageData.data as SelecRoomData;

    final stmt = _db.prepare(
      '''
      SELECT * FROM ${app.DatabaseTables.rooms.name}
      WHERE ${RoomsTableAttributes.homeId.name} = ?
      ''');

      
    ResultSet resultSet = stmt.select([room.homeId]);
    
    stmt.dispose();
    return [];
  }
  
  @override
  int get taskId => app.DatabaseActions.selectHome.index;
}

