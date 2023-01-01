import 'package:smarthome_algeria/src/features/devices/devices_feature.dart';
import 'package:smarthome_algeria/src/features/home/domain/home.dart';
import 'package:smarthome_algeria/src/features/room/domain/room.dart';
import 'package:smarthome_algeria/src/services/localDatabase/devicesTable/delegate.dart';
import 'package:smarthome_algeria/src/services/localDatabase/roomsTable/delegate.dart';
import 'package:sqlite3/common.dart';

import '../homesTable/delegate.dart';

List<Home> resultSetToHomeList(ResultSet resultSet) {
  List<Home> homes = [];
  Home home;
  for (Row row in resultSet) {
    try {
      home = Home(
          index: homes.length,
          name: row[HomeTableAttributes.homeName.name],
          id: row[HomeTableAttributes.homeId.name]);
      homes.add(home);
    } on Exception {
      // nothing to do
    }
  }
  return homes;
}

Room resultSetToRoom(Row roomRow,ResultSet devicesResultSet) {
    List<Device> devices = [];

  Room room = Room(
      homeId: roomRow[RoomsTableAttributes.homeId.name],
      name: roomRow[RoomsTableAttributes.roomName.name],
      id: roomRow[RoomsTableAttributes.roomId.name],
      devices: devices
      );

  Device device;
  List<DeviceType> deviceTypes = DeviceType.values;

  for (Row row in devicesResultSet) {
    try {
      int deviceTypeIndex = row[DevicesTableAttributes.deviceType.name];
      DeviceType deviceType = deviceTypes[deviceTypeIndex];

      device = Device(
          id: row[DevicesTableAttributes.deviceId.name],
          name: row[DevicesTableAttributes.deviceName.name],
          type: deviceType,
          roomId: row[DevicesTableAttributes.roomId.name],
          homeId: row[DevicesTableAttributes.homeId.name],
          icon: devicesIcons[deviceTypeIndex],
          powerConsumption: row[DevicesTableAttributes.deviceConsumption.name],
      );

      devices.add(device);
    } on Exception {
      // nothing to do
    }
  }

  return room;
}



