import 'package:equatable/equatable.dart';
import 'package:smarthome_algeria/src/features/devices/data/device_archetype.dart';
import 'package:smarthome_algeria/src/features/devices/data/devices.dart';
import 'package:smarthome_algeria/src/features/home/domain/home.dart';
import 'package:smarthome_algeria/src/features/room/domain/room.dart';

class AppState extends Equatable {
  final List<Home> homes;
  final int currentHomeIndex;

  const AppState({required this.homes, this.currentHomeIndex = 0});

  static AppState initialState({List<Home>? homes, Home? currentHome}) {
    homes ??= [];

    return AppState(homes: homes, currentHomeIndex: 0);
  }

  @override
  List<Object?> get props => [homes, currentHomeIndex];

  AppState copyWith({List<Home>? homes, int? currentHomeIndex}) {
    return AppState(
      homes: homes ?? this.homes,
      currentHomeIndex: currentHomeIndex ?? this.currentHomeIndex,
    );
  }

  List<Room> get rooms {
    return currentHome?.rooms ?? [];
  }

  Home? get currentHome {
    if (currentHomeIndex >= homes.length) {
      return null;
    }
    return homes[currentHomeIndex];
  }

  List<Device> getArchetypeDeviceList(DeviceArchetype deviceArchetype) {
    List<Device> devices = [];

    for (Room room in rooms) {
      for (Device device in room.devices) {
        if (device.type == deviceArchetype.type) {
          devices.add(device);
        }
      }
    }
    
    return devices;
  }

  int getDeviceArchetypeCount(DeviceType type) {
    int count = 0;

    for (Room room in rooms) {
      for (Device device in room.devices) {
        if (device.type == type) {
          count++;
        }
      }
    }

    return count;
  }
}
