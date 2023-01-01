

import 'dart:ffi';
import "package:ffi/ffi.dart";


class DeviceData {
  final int deviceId;
  final int turnedOn;
  final int deviceType;

  DeviceData({required this.deviceId, required this.turnedOn, required this.deviceType});
}


abstract class DeviceStateData extends Struct{

  @Int32()
  external int deviceId;

  @Int32()
  external int turnedOn;

  @Int32()
  external int deviceType;


  static DeviceStateData allocate() => calloc<DeviceStateData>().ref;

}

enum ApiTasks {
  postDeviceState,

}