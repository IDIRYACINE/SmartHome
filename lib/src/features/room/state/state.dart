import 'package:equatable/equatable.dart';
import 'package:smarthome_algeria/src/features/devices/data/device_archetype.dart';
import 'package:smarthome_algeria/src/features/devices/data/devices.dart';
import 'package:smarthome_algeria/src/features/room/domain/room.dart';

class RoomState extends Equatable {
  final List<RoomGroup> roomGroups;
  final int currentHomeId;

  const RoomState( {required this.roomGroups,this.currentHomeId = 0});

  static RoomState initialState() {
    return const RoomState(roomGroups:[]);
  }

  @override
  List<Object?> get props => [rooms];

  RoomState copyWith({
    List<RoomGroup>? roomGroups,
    int? currentHomeId
  }) {
    return RoomState(
      roomGroups: roomGroups ?? this.roomGroups,
      currentHomeId: currentHomeId ?? this.currentHomeId,
    );
  }

  int getDeviceArchetypeCount(DeviceType type) {
    return 0;
  }

  List<Device> getArchetypeDeviceList(DeviceArchetype deviceArchetype) {
    return [];
  }


  List<Room> get rooms => roomGroup?.rooms ?? [];
  RoomGroup? get roomGroup => _getRoomGroupByHomeId(currentHomeId);

  RoomGroup? _getRoomGroupByHomeId(int homeId) {
    RoomGroup? result;

    // linear search for now
    for (int i = 0 ; i < roomGroups.length ; i++) {
      if (roomGroups[i].homeId == homeId) {
        result = roomGroups[i];
      }
    }

    return result;
  }


}
