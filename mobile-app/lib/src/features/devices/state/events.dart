import '../data/devices.dart';

class DeviceEvent {}

class AddDevice extends DeviceEvent {
  final Device device;

  AddDevice(
      {required this.device,});
}

class UpdateDevice extends DeviceEvent {
  final Device device;

  UpdateDevice( {
    required this.device,
  });
}

class RemoveDevice extends DeviceEvent {
  final Device device;


  RemoveDevice({required  this.device});
}
