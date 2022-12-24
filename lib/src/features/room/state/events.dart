
import 'package:smarthome_algeria/src/features/devices/data/devices.dart';


class RoomEvents {}


class AddDevice extends RoomEvents {
  final DeviceType type;
  final int consumption;
  final String name;

  AddDevice(this.type, this.consumption, this.name);
}

class UpdateDevice extends RoomEvents {
  final Device device;
  final int index;

  UpdateDevice(this.device, this.index);
}

class RemoveDevice extends RoomEvents {
  final int index;
  final Device device;

  RemoveDevice(this.index, this.device);
}

