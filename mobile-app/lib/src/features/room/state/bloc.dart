import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_algeria/src/features/devices/data/devices.dart';
import 'package:smarthome_algeria/src/features/devices/devices_feature.dart'
    as devices;
import 'package:smarthome_algeria/src/features/room/domain/room.dart';
import 'package:smarthome_algeria/src/features/room/state/events.dart';
import 'package:smarthome_algeria/src/features/room/state/state.dart';

class RoomBloc extends Bloc<RoomEvents, RoomState> {
  final devices.DevicesBloc devicesBloc;

  RoomBloc(this.devicesBloc, {RoomState? initialState})
      : super(initialState ?? RoomState.initialState()) {
    on<AddRoom>(_addRoom);
    on<UpdateRoom>(_updateRoom);
    on<RemoveRoom>(_removeRoom);

    on<AddDevice>(_addDevice);
    on<UpdateDevice>(_updateDevice);
    on<RemoveDevice>(_removeDevice);

    on<AddHomeGroup>(_notifyHomeAdded);
    on<RemoveHomeGroup>(_notifyHomeRemoved);
  }

  void _addRoom(AddRoom event, Emitter<RoomState> emit) {
    if (state.currentHomeRooms != null) {
      final List<Room> updatedRooms = List.from(state.currentHomeRooms!.rooms);

      int index = updatedRooms.length;
      Room room = Room(id: index, name: event.roomName);

      updatedRooms.add(room);

      final updatedGroupRoom =
          state.currentHomeRooms!.copyWith(rooms: updatedRooms);

      final updatedHomeRooms = state.roomGroups
          .map((e) => e.homeId == state.currentHomeId ? updatedGroupRoom : e)
          .toList();

      emit(
        state.copyWith(
            roomGroups: updatedHomeRooms, roomGroup: updatedGroupRoom),
      );
    }
  }

  void _updateRoom(UpdateRoom event, Emitter<RoomState> emit) {
    if (state.currentHomeRooms != null) {
      final List<Room> updatedRooms = state.currentHomeRooms!.rooms.map((e) {
        if (e.id == event.room.id) {
          return event.room;
        } else {
          return e;
        }
      }).toList();

      final updatedGroupRoom =
          state.currentHomeRooms!.copyWith(rooms: updatedRooms);

      final updatedHomeRooms = state.roomGroups
          .map((e) => e.homeId == state.currentHomeId ? updatedGroupRoom : e)
          .toList();

      emit(
        state.copyWith(
            roomGroups: updatedHomeRooms, roomGroup: updatedGroupRoom),
      );
    }
  }

  void _removeRoom(RemoveRoom event, Emitter<RoomState> emit) {
    if (state.currentHomeRooms != null) {
      final List<Room> updatedRooms = List.unmodifiable(state
          .currentHomeRooms!.rooms
          .where((room) => room.id != event.room.id));

      final updatedGroupRoom =
          state.currentHomeRooms!.copyWith(rooms: updatedRooms);

      final updatedHomeRooms = state.roomGroups
          .map((e) => e.homeId == state.currentHomeId ? updatedGroupRoom : e)
          .toList();

      emit(
        state.copyWith(
            roomGroups: updatedHomeRooms, roomGroup: updatedGroupRoom),
      );
    }
  }

  void _notifyHomeAdded(AddHomeGroup event, Emitter<RoomState> emit) {
    final List<RoomGroup> updatedHomeRooms = List.from(state.roomGroups);
    RoomGroup group = RoomGroup(homeId: event.homeId, rooms: []);
    updatedHomeRooms.add(group);

    emit(state.copyWith(roomGroups: updatedHomeRooms, roomGroup: group));
  }

  void _notifyHomeRemoved(RemoveHomeGroup event, Emitter<RoomState> emit) {
    final List<RoomGroup> updatedHomeRooms = List.unmodifiable(state.roomGroups
        .where((roomGroup) => roomGroup.homeId != event.homeId));

    emit(state.copyWith(roomGroups: updatedHomeRooms));
  }

  FutureOr<void> _addDevice(AddDevice event, Emitter<RoomState> emit) {
    final List<Device> updatedDevices =
        List.from(state.currentHomeRooms!.rooms[event.roomIndex].devices);

    Device newDevice = Device(
        powerConsumption: event.consumption,
        id: updatedDevices.length,
        name: event.name,
        type: event.type,
        icon: devicesIcons[event.type.index]);

    updatedDevices.add(newDevice);

    final updatedRoom = state.currentHomeRooms!.rooms[event.roomIndex]
        .copyWith(devices: updatedDevices);

    final List<Room> updatedRooms =
        List.from(state.currentHomeRooms!.rooms.map((room) {
      if (room.id == updatedRoom.id) {
        return updatedRoom;
      } else {
        return room;
      }
    }));

    final updatedGroupRoom =
        state.currentHomeRooms!.copyWith(rooms: updatedRooms);

    final updateGroupRooms = state.roomGroups
        .map((e) => e.homeId == state.currentHomeId ? updatedGroupRoom : e)
        .toList();

    devicesBloc.add(devices.AddDevice(
      device: newDevice,
    ));

    emit(state.copyWith(
        roomGroups: updateGroupRooms, roomGroup: updatedGroupRoom));
  }

  FutureOr<void> _updateDevice(UpdateDevice event, Emitter<RoomState> emit) {
    final List<Device> updatedDevices = List.from(state
        .currentHomeRooms!.rooms[event.roomIndex].devices
        .map((e) => e.id == event.device.id ? event.device : e));

    final updatedRoom = state.currentHomeRooms!.rooms[event.roomIndex]
        .copyWith(devices: updatedDevices);

    final List<Room> updatedRooms =
        List.from(state.currentHomeRooms!.rooms.map((room) {
      if (room.id == updatedRoom.id) {
        return updatedRoom;
      } else {
        return room;
      }
    }));

    final updatedGroupRoom =
        state.currentHomeRooms!.copyWith(rooms: updatedRooms);

    final updateGroupRooms = state.roomGroups
        .map((e) => e.homeId == state.currentHomeId ? updatedGroupRoom : e)
        .toList();

    devicesBloc.add(devices.UpdateDevice(device: event.device));

    emit(state.copyWith(
        roomGroups: updateGroupRooms, roomGroup: updatedGroupRoom));
  }

  FutureOr<void> _removeDevice(RemoveDevice event, Emitter<RoomState> emit) {
    final List<Device> updatedDevices = List.unmodifiable(state
        .currentHomeRooms!.rooms[event.roomIndex].devices
        .where((device) => device.id != event.device.id));

    final updatedRoom = state.currentHomeRooms!.rooms[event.roomIndex]
        .copyWith(devices: updatedDevices);

    final List<Room> updatedRooms =
        List.from(state.currentHomeRooms!.rooms.map((room) {
      if (room.id == updatedRoom.id) {
        return updatedRoom;
      } else {
        return room;
      }
    }));

    final updatedGroupRoom =
        state.currentHomeRooms!.copyWith(rooms: updatedRooms);

    final updateGroupRooms = state.roomGroups
        .map((e) => e.homeId == state.currentHomeId ? updatedGroupRoom : e)
        .toList();

    devicesBloc.add(
      devices.RemoveDevice(
        device: event.device,
      ),
    );

    emit(state.copyWith(
        roomGroups: updateGroupRooms, roomGroup: updatedGroupRoom));
  }
}
