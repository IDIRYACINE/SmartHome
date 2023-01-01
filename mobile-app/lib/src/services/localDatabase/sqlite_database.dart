import 'dart:async';

import 'package:smarthome_algeria/src/services/localDatabase/roomsTable/load_all_rooms.dart';
import 'package:smarthome_algeria/src/services/localDatabase/types.dart' as app;
import 'package:smarthome_algeria/src/services/servicesProvider/types.dart';

import 'package:sqlite3/sqlite3.dart';
import 'devicesTable/delegate.dart';
import 'homesTable/delegate.dart';
import 'roomsTable/delegate.dart';

class SqliteDatabase implements app.Database {
  late String _filename;
  late Database _db;

  final List<TaskDelegate> _actions = [];

  bool isConnected = false;

  SqliteDatabase({String filename = 'smarthome.db', String dbPath = ''}) {
    _filename = "$dbPath/$filename";
  }

  @override
  Future<bool> connect() async {
    try {
      _db = sqlite3.open(_filename);

      createTables();
      _registerActions();

      isConnected = true;
    } catch (e) {
//
    }

    return isConnected;
  }

  @override
  Future<void> createTables() async {
    String stmt = _createHomesTable();
    _db.execute(stmt);

    stmt = _createRoomsTable();
    _db.execute(stmt);

    stmt = _createDevicesTable();
    _db.execute(stmt);
  }

  @override
  Future<void> disconnect() async {
    _db.dispose();
  }

  @override
  Future<ServiceResponse> handleMessage(ServiceMessageData message) async {
    ServiceResponse response;

    if (!isConnected) {
      await connect();
    }

    try {
      final action = _actions[message.taskId];
      await action.setTaskData(message);
      response = await action.execute();
    } catch (e) {
      response = ServiceResponse(
        data: null,
        messageId: message.messageId,
        status: OperationStatus.error,
      );
    }
    return response;
  }

  String _createHomesTable() {
    String stmt =
        ''' CREATE Table IF NOT EXISTS ${app.DatabaseTables.homes.name} (
      ${HomeTableAttributes.homeId.name} ${HomeTableAttributes.homeId.type},
      ${HomeTableAttributes.homeName.name} ${HomeTableAttributes.homeName.type})''';

    return stmt;
  }

  String _createRoomsTable() {
    String stmt =
        ''' CREATE Table IF NOT EXISTS ${app.DatabaseTables.rooms.name} (
      ${RoomsTableAttributes.homeId.name} ${RoomsTableAttributes.homeId.type},
      ${RoomsTableAttributes.roomId.name} ${RoomsTableAttributes.roomId.name},
      ${RoomsTableAttributes.roomName.name} ${RoomsTableAttributes.roomName.name},
      PRIMARY KEY (${RoomsTableAttributes.homeId.name}, ${RoomsTableAttributes.roomId.name}))''';

    return stmt;
  }

  String _createDevicesTable() {
    String stmt =
        ''' CREATE Table IF NOT EXISTS ${app.DatabaseTables.devices.name} (
      ${DevicesTableAttributes.homeId.name} ${DevicesTableAttributes.homeId.type},
      ${DevicesTableAttributes.roomId.name} ${DevicesTableAttributes.roomId.name},
      ${DevicesTableAttributes.deviceId.name} ${DevicesTableAttributes.deviceId.name},
      ${DevicesTableAttributes.deviceName.name} ${DevicesTableAttributes.deviceName.name},
      ${DevicesTableAttributes.deviceType.name} ${DevicesTableAttributes.deviceType.name},
      PRIMARY KEY (${DevicesTableAttributes.homeId.name}, ${DevicesTableAttributes.roomId.name}, ${DevicesTableAttributes.deviceId.name})
      )
    ''';

    return stmt;
  }

  void _registerActions() {
    //important same order as in the enum
    _actions
      ..add(InsertHome(_db))
      ..add(InsertRoom(_db))
      ..add(InsertDevice(_db))
      ..add(UpdateHome(_db))
      ..add(UpdateRoom(_db))
      ..add(UpdateDevice(_db))
      ..add(DeleteHome(_db))
      ..add(DeleteRoom(_db))
      ..add(DeleteDevice(_db))
      ..add(SelectAllHomes(_db))
      ..add(SelectRoom(_db))
      ..add(LoadAllRooms(_db))
      ..add(SelectDevice(_db));
  }

  @override
  int get serviceId => AppServices.localDatabase.index;
}
