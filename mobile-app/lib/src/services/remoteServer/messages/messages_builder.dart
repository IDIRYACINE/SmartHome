

import 'package:smarthome_algeria/src/features/devices/devices_feature.dart';
import 'package:smarthome_algeria/src/services/remoteServer/service.dart';


abstract class RemoteServerMessageBuilder{

  static PostDeviceStateMessage postDeviceStateMessage(Device device, bool isOn){
    return PostDeviceStateMessage(device, isOn);
  }
}