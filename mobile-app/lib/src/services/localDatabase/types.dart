

import 'package:smarthome_algeria/src/services/servicesProvider/types.dart';



abstract class Database implements Service {
  Future<bool> connect();
  Future<void> disconnect();

  Future<void> createTables();

}



enum DatabaseTables {
  homes,
  devices,
  rooms
}


extension Attributes on DatabaseTables {
  String get name {
    switch (this) {
      case DatabaseTables.homes:
        return 'Homes';
      case DatabaseTables.devices:
        return 'Devices';
      case DatabaseTables.rooms:
        return 'Rooms';
    }
  }

  
}


enum DatabaseActions{
  insertHome,
  insertRoom,
  insertDevice,
  updateHome,
  updateRoom,
  updateDevice,
  deleteHome,
  deleteRoom,
  deleteDevice,
  selectHome,
  selectRoom,
  selectDevice,
}