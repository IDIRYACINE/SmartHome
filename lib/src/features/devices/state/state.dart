import 'package:smarthome_algeria/src/features/devices/data/device_archetype.dart';
import 'package:smarthome_algeria/src/features/devices/data/devices.dart';

class DevicesState{
  final List<Device> lightDevice;
  final List<Device> plugDevices;
  final List<Device> lockDevices;

  DevicesState({required this.lightDevice, required this.plugDevices,required this.lockDevices});



  List<Device> getArchetypeDeviceList(DeviceArchetype deviceArchetype) {
    switch (deviceArchetype.type) {
      case DeviceType.light:
        return lightDevice;
      case DeviceType.plug:
        return plugDevices;
      case DeviceType.lock:
        return lockDevices;
    }
  }

  int getDeviceArchetypeCount(DeviceType type) {
    switch (type) {
      case DeviceType.light:
        return lightDevice.length;
      case DeviceType.plug:
        return plugDevices.length;
      case DeviceType.lock:
        return lockDevices.length;
    }
  }

  List<Device> getDeviceListByType(DeviceType type) {
    switch (type) {
      case DeviceType.light:
        return lightDevice;
      case DeviceType.plug:
        return plugDevices;
      case DeviceType.lock:
        return lockDevices;
    }
  }

  static initialState() {
    return DevicesState(lightDevice: [], lockDevices: [], plugDevices: []);
  }

  DevicesState copyWith({List<Device>? lightDevice, List<Device>? plugDevices, List<Device>? lockDevices}) {
    return DevicesState(
      lightDevice: lightDevice ?? this.lightDevice,
      plugDevices: plugDevices ?? this.plugDevices,
      lockDevices: lockDevices ?? this.lockDevices,
    );
  }

  DevicesState copyWithDeviceType(DeviceType type, List<Device> devices) {
    switch (type) {
      case DeviceType.light:
        return copyWith(lightDevice: devices);
      case DeviceType.plug:
        return copyWith(plugDevices: devices);
      case DeviceType.lock:
        return copyWith(lockDevices: devices);
    }
  }

}