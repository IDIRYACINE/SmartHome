

import 'dart:ffi';
import "package:ffi/ffi.dart";


class DeviceData {
  final int deviceId;
  final bool turnedOn;
  final int deviceType;

  DeviceData({required this.deviceId, required this.turnedOn, required this.deviceType});
}


abstract class DeviceStateData extends Struct{

  @Int32()
  external int deviceId;

  @Bool()
  external bool turnedOn;

  @Int32()
  external int deviceType;


  static DeviceStateData allocate() => calloc<DeviceStateData>().ref;

}

enum ApiTasks {
  postDeviceState,

}