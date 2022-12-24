import 'package:smarthome_algeria/src/features/room/room_feature.dart';

class Home {
  final String name;
  final int id;
  final List<Room> rooms;
  final int index;

  Home(
      {required this.index,
      required this.name,
      required this.id,
      this.rooms = const []});

  Home copyWith({String? name, int? id, int? index, List<Room>? rooms}) {
    return Home(
        index: index ?? this.index,
        name: name ?? this.name,
        id: id ?? this.id,
        rooms: rooms ?? this.rooms);
  }
}
