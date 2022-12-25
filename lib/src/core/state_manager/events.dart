import 'package:smarthome_algeria/src/features/devices/data/devices.dart';
import 'package:smarthome_algeria/src/features/home/domain/home.dart';
import 'package:smarthome_algeria/src/features/room/domain/room.dart';

class AppEvents {}

class AddHome extends AppEvents {
  final String homeName;

  AddHome(
    this.homeName,
  );
}

class UpdateHome extends AppEvents {
  final Home home;
  final int index;

  UpdateHome(this.home, this.index);
}

class RemoveHome extends AppEvents {
  final int index;
  final int homeId;

  RemoveHome(this.index, this.homeId);
}

class SelectHome extends AppEvents {
  final Home home;

  SelectHome(this.home);
}

class AddRoom extends AppEvents {
  final String roomName;

  AddRoom(this.roomName,);
}

class UpdateRoom extends AppEvents {
  final Room room;
  final int index;

  UpdateRoom(this.room,this.index);
}

class RemoveRoom extends AppEvents {
  final Room room;

  RemoveRoom(this.room, );
}



class AddDevice extends AppEvents {
  final DeviceType type;
  final int consumption;
  final String name;
  final int roomIndex;

  AddDevice(
      {required this.type,
      required this.consumption,
      required this.name,
      required this.roomIndex});
}

class UpdateDevice extends AppEvents {
  final Device device;
  final int index;
  final int roomIndex;

  UpdateDevice(
      {required this.device,
      required this.index,
      required this.roomIndex,
      });
}

class RemoveDevice extends AppEvents {
  final int index;
  final Device device;
  final int roomIndex;

  RemoveDevice(this.index, this.device, this.roomIndex);
} 