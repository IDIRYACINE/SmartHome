import 'package:smarthome_algeria/src/features/devices/data/devices.dart';

class Room {
  String name;
  int id;
  String? description;

  final List<Device> devices;

  final List<Device> lightDevices;
  final List<Device> lockDevices;
  final List<Device> plugDevices;

  Room({
    required this.name,
    required this.id,
    this.description,
    this.lightDevices = const [],
    this.lockDevices = const [],
    this.plugDevices = const [],
    this.devices = const [],
  });

  Room copyWith({
    String? name,
    int? id,
    String? description,
    List<Device>? devices,
    List<Device>? lightDevices,
    List<Device>? lockDevices,
    List<Device>? plugDevices,
  }) {
    return Room(
      name: name ?? this.name,
      id: id ?? this.id,
      description: description ?? this.description,
      devices: devices ?? this.devices,
      lightDevices: lightDevices ?? this.lightDevices,
      lockDevices: lockDevices ?? this.lockDevices,
      plugDevices: plugDevices ?? this.plugDevices,
    );
  }

  Room copyWithDeviceType({
    String? name,
    int? id,
    String? description,
    required DeviceType type,
    required List<Device> updatedDevices,
    required List<Device> updatedAllDevice,
  }) {
    switch (type) {
      case DeviceType.light:
        return copyWith(
          name: name,
          id: id,
          description: description,
          devices: updatedAllDevice,
          lightDevices: updatedDevices,
        );
      case DeviceType.plug:
        return copyWith(
          name: name,
          id: id,
          description: description,
          devices: updatedAllDevice,
          plugDevices: updatedDevices,
        );
      case DeviceType.lock:
        return copyWith(
          name: name,
          id: id,
          description: description,
          devices: updatedAllDevice,
          lockDevices: updatedDevices,
        );
    }
  }

  List<Device> getDeviceList(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.light:
        return lightDevices;
      case DeviceType.plug:
        return plugDevices;
      case DeviceType.lock:
        return lockDevices;
    }
  }
}

class RoomGroup {
  final int homeId;
  final List<Room> rooms;

  RoomGroup(this.homeId, this.rooms);
}
