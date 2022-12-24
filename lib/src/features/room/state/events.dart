
import 'package:smarthome_algeria/src/features/devices/domain/device.dart';


class RoomEvents {}


class AddDevice extends RoomEvents {
  final Device device;
  final int index;

  AddDevice(this.device, this.index);
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

