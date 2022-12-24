import 'package:equatable/equatable.dart';
import 'package:smarthome_algeria/src/features/devices/data/devices.dart';

class RoomState extends Equatable {
  final List<Device> lightDevices;
  final List<Device> plugDevices;
  final List<Device> lockDevices;

  List<Device> getDeviceList(DeviceType deviceType){
    switch(deviceType){
      case DeviceType.light:
        return lightDevices;
      case DeviceType.plug:
        return plugDevices;
      case DeviceType.lock:
        return lockDevices;
    }
  }

  const RoomState(this.lightDevices, this.plugDevices, this.lockDevices);

  static RoomState initialState() {
    return const RoomState([], [], []);
  }

  @override
  List<Object?> get props => [lightDevices];

  RoomState copyWith({
    List<Device>? lightDevices,
    List<Device>? plugDevices,
    List<Device>? lockDevices,
  }) {
    return RoomState(
      lightDevices ?? this.lightDevices,
      plugDevices ?? this.plugDevices,
      lockDevices ?? this.lockDevices,
    );
  }

  RoomState copyWithDeviceType(DeviceType deviceType, List<Device> devices){
    switch(deviceType){
      case DeviceType.light:
        return copyWith(lightDevices: devices);
      case DeviceType.plug:
        return copyWith(plugDevices: devices);
      case DeviceType.lock:
        return copyWith(lockDevices: devices);
    }
  }
  
}
