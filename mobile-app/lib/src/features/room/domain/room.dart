import 'package:smarthome_algeria/src/features/devices/data/devices.dart';

class Room {
  String name;
  int id;
  String? description;
  int homeId;

  final List<Device> devices;

  Room({
    required this.name,
    required this.id,
    this.description,
    required this.homeId,
    this.devices = const [],
  });

  Room copyWith({
    String? name,
    int? id,
    String? description,
    List<Device>? devices,
    int? homeId,
  }) {
    return Room(
      name: name ?? this.name,
      id: id ?? this.id,
      homeId: homeId ?? this.homeId,
      description: description ?? this.description,
      devices: devices ?? this.devices,
    );
  }
}

class RoomGroup {
  final int homeId;
  final List<Room> rooms;

  RoomGroup({required this.homeId, this.rooms = const []});

  RoomGroup copyWith({int? homeId, List<Room>? rooms}) {
    return RoomGroup(homeId: homeId ?? this.homeId, rooms: rooms ?? this.rooms);
  }
}
