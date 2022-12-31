
import 'package:smarthome_algeria/src/features/devices/data/devices.dart';
import 'package:smarthome_algeria/src/features/home/domain/home.dart';

import '../domain/room.dart';

class RoomEvents {}


class AddRoom extends RoomEvents {
  final String roomName;

  AddRoom(this.roomName,);
}

class UpdateRoom extends RoomEvents {
  final Room room;
  final int roomIndex;

  UpdateRoom(this.room,this.roomIndex);
}

class RemoveRoom extends RoomEvents {
  final Room room;

  RemoveRoom(this.room, );
}

class AddHomeGroup extends RoomEvents {
  final int homeId;

  AddHomeGroup(this.homeId);
}

class RemoveHomeGroup extends RoomEvents {
  final int homeId;

  RemoveHomeGroup(this.homeId);
}


class NotifyHomesLoaded extends RoomEvents {
  final List<Home> homes;

  NotifyHomesLoaded(this.homes);
}

class NotifyHomeSelected extends RoomEvents {
  final int homeId;

  NotifyHomeSelected(this.homeId);
}

class AddDevice extends RoomEvents {
  final DeviceType type;
  final int consumption;
  final String name;
  final int roomId;
  final int homeId;
  final int roomIndex;

  AddDevice(
      {required this.type,
      required this.roomIndex, 
      required this.consumption,
      required this.name,
      required this.homeId,
      required this.roomId});
}

class UpdateDevice extends RoomEvents {
  final Device device;
  final int deviceIndex;
  final int roomIndex;

  UpdateDevice({
    required this.device,
    required this.deviceIndex,
    required this.roomIndex,
  });
}

class RemoveDevice extends RoomEvents {
  final Device device;
  final int roomIndex;
  final int deviceIndex;

  RemoveDevice({required this.deviceIndex,required  this.device,required  this.roomIndex});
}


