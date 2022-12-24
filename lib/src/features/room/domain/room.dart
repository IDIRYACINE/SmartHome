import 'package:smarthome_algeria/src/features/devices/domain/device.dart';

class Room {
  String name;
  int id;
  String? description;
  List<Device> devices;

  Room({
    required this.name,
    required this.id,
    this.description,
    required this.devices,
  });

  Room copyWith(
      {String? name, int? id, String? description, List<Device>? devices}) {
    return Room(
        name: name ?? this.name,
        id: id ?? this.id,
        devices: devices ?? this.devices);
  }
}
