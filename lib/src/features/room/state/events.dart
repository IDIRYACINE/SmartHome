import 'package:smarthome_algeria/src/features/devices/data/devices.dart';

class RoomEvents {}

class AddDevice extends RoomEvents {
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

class UpdateDevice extends RoomEvents {
  final Device device;
  final int index;
  final int roomIndex;

  UpdateDevice(
      {required this.device,
      required this.index,
      required this.roomIndex,
      });
}

class RemoveDevice extends RoomEvents {
  final int index;
  final Device device;
  final int roomIndex;

  RemoveDevice(this.index, this.device, this.roomIndex);
}

class SelectCurrentHome extends RoomEvents {
  final int homeId;

  SelectCurrentHome(this.homeId);
}
