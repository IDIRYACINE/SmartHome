import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_algeria/src/features/devices/data/devices.dart';
import 'package:smarthome_algeria/src/features/devices/devices_feature.dart'
    as devices;
import 'package:smarthome_algeria/src/features/room/domain/room.dart';
import 'package:smarthome_algeria/src/features/room/state/events.dart';
import 'package:smarthome_algeria/src/features/room/state/state.dart';
import 'package:smarthome_algeria/src/services/localDatabase/service.dart';
import 'package:smarthome_algeria/src/services/servicesProvider/services_store.dart';
import 'package:smarthome_algeria/src/services/servicesProvider/types.dart';

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
    on<NotifyHomesLoaded>(_notifyHomesLoaded);
    on<NotifyHomeSelected>(_notifyHomeSelected);
    on<RemoveHomeGroup>(_notifyHomeRemoved);
  }

  void _addRoom(AddRoom event, Emitter<RoomState> emit) {
    if (state.roomGroup != null) {
      final List<Room> updatedRooms = List.from(state.roomGroup!.rooms);

      int index = updatedRooms.length;
      Room room = Room(id: index, name: event.roomName);

      updatedRooms.add(room);

      final updatedGroupRoom =
          state.roomGroup!.copyWith(rooms: updatedRooms);

      final updatedHomeRooms = state.roomGroups
          .map((e) => e.homeId == state.currentHomeId ? updatedGroupRoom : e)
          .toList();

      _addRoomOnDatabase(room);

      emit(
        state.copyWith(
            roomGroups: updatedHomeRooms),
      );
    }
  }

  void _updateRoom(UpdateRoom event, Emitter<RoomState> emit) {
    if (state.roomGroup != null) {
      final List<Room> updatedRooms = state.roomGroup!.rooms.map((e) {
        if (e.id == event.room.id) {
          return event.room;
        } else {
          return e;
        }
      }).toList();

      final updatedGroupRoom =
          state.roomGroup!.copyWith(rooms: updatedRooms);

      final updatedHomeRooms = state.roomGroups
          .map((e) => e.homeId == state.currentHomeId ? updatedGroupRoom : e)
          .toList();

      _updateRoomOnDatabase(event.room);

      emit(
        state.copyWith(
            roomGroups: updatedHomeRooms),
      );
    }
  }

  void _removeRoom(RemoveRoom event, Emitter<RoomState> emit) {
    if (state.roomGroup != null) {
      final List<Room> updatedRooms = List.unmodifiable(state
          .roomGroup!.rooms
          .where((room) => room.id != event.room.id));

      final updatedGroupRoom =
          state.roomGroup!.copyWith(rooms: updatedRooms);

      final updatedHomeRooms = state.roomGroups
          .map((e) => e.homeId == state.currentHomeId ? updatedGroupRoom : e)
          .toList();

      _removeRoomOnDatabase(event.room);

      emit(
        state.copyWith(
            roomGroups: updatedHomeRooms,),
      );
    }
  }

  void _notifyHomeAdded(AddHomeGroup event, Emitter<RoomState> emit) {
    final List<RoomGroup> updatedHomeRooms = List.from(state.roomGroups);
    RoomGroup group = RoomGroup(homeId: event.homeId, rooms: []);
    updatedHomeRooms.add(group);


    emit(state.copyWith(
      roomGroups: updatedHomeRooms,
      
    ));
  }

  void _notifyHomeRemoved(RemoveHomeGroup event, Emitter<RoomState> emit) {
    final List<RoomGroup> updatedHomeRooms = List.unmodifiable(state.roomGroups
        .where((roomGroup) => roomGroup.homeId != event.homeId));

    emit(state.copyWith(roomGroups: updatedHomeRooms));
  }

  FutureOr<void> _addDevice(AddDevice event, Emitter<RoomState> emit) {
    final List<Device> updatedDevices =
        List.from(state.roomGroup!.rooms[event.roomIndex].devices);

    Device newDevice = Device(
        powerConsumption: event.consumption,
        id: updatedDevices.length,
        name: event.name,
        type: event.type,
        icon: devicesIcons[event.type.index]);

    updatedDevices.add(newDevice);

    final updatedRoom = state.roomGroup!.rooms[event.roomIndex]
        .copyWith(devices: updatedDevices);

    final List<Room> updatedRooms =
        List.from(state.roomGroup!.rooms.map((room) {
      if (room.id == updatedRoom.id) {
        return updatedRoom;
      } else {
        return room;
      }
    }));

    final updatedGroupRoom =
        state.roomGroup!.copyWith(rooms: updatedRooms);

    final updateGroupRooms = state.roomGroups
        .map((e) => e.homeId == state.currentHomeId ? updatedGroupRoom : e)
        .toList();

    devicesBloc.add(devices.AddDevice(
      device: newDevice,
    ));

    emit(state.copyWith(
        roomGroups: updateGroupRooms, ));
  }

  FutureOr<void> _updateDevice(UpdateDevice event, Emitter<RoomState> emit) {
    final List<Device> updatedDevices = List.from(state
        .roomGroup!.rooms[event.roomIndex].devices
        .map((e) => e.id == event.device.id ? event.device : e));

    final updatedRoom = state.roomGroup!.rooms[event.roomIndex]
        .copyWith(devices: updatedDevices);

    final List<Room> updatedRooms =
        List.from(state.roomGroup!.rooms.map((room) {
      if (room.id == updatedRoom.id) {
        return updatedRoom;
      } else {
        return room;
      }
    }));

    final updatedGroupRoom =
        state.roomGroup!.copyWith(rooms: updatedRooms);

    final updateGroupRooms = state.roomGroups
        .map((e) => e.homeId == state.currentHomeId ? updatedGroupRoom : e)
        .toList();

    devicesBloc.add(devices.UpdateDevice(device: event.device));

    emit(state.copyWith(
        roomGroups: updateGroupRooms));
  }

  FutureOr<void> _removeDevice(RemoveDevice event, Emitter<RoomState> emit) {
    final List<Device> updatedDevices = List.unmodifiable(state
        .roomGroup!.rooms[event.roomIndex].devices
        .where((device) => device.id != event.device.id));

    final updatedRoom = state.roomGroup!.rooms[event.roomIndex]
        .copyWith(devices: updatedDevices);

    final List<Room> updatedRooms =
        List.from(state.roomGroup!.rooms.map((room) {
      if (room.id == updatedRoom.id) {
        return updatedRoom;
      } else {
        return room;
      }
    }));

    final updatedGroupRoom =
        state.roomGroup!.copyWith(rooms: updatedRooms);

    final updateGroupRooms = state.roomGroups
        .map((e) => e.homeId == state.currentHomeId ? updatedGroupRoom : e)
        .toList();

    devicesBloc.add(
      devices.RemoveDevice(
        device: event.device,
      ),
    );

    emit(state.copyWith(
        roomGroups: updateGroupRooms));
  }

  void _addRoomOnDatabase(Room room) {
    ServiceMessage message =
        DatabaseMessageBuilder.addRoomMessage(room, state.currentHomeId, () {});
    ServicesProvider.instance.sendMessage(message);
  }

  void _removeRoomOnDatabase(Room room) {
    ServiceMessage message = DatabaseMessageBuilder.updateRoomMessage(
        room, state.currentHomeId, () {});
    ServicesProvider.instance.sendMessage(message);
  }

  void _updateRoomOnDatabase(Room room) {
    ServiceMessage message = DatabaseMessageBuilder.deleteRoomMessage(
        room, state.currentHomeId, () {});
    ServicesProvider.instance.sendMessage(message);
  }

  FutureOr<void> _notifyHomesLoaded(NotifyHomesLoaded event, Emitter<RoomState> emit) {
    final List<RoomGroup> updatedHomeRooms =[];

    for (var home in event.homes) {
      RoomGroup group = RoomGroup(homeId: home.id, rooms: []);
      updatedHomeRooms.add(group);
    }

    emit(state.copyWith(
      roomGroups: updatedHomeRooms,
    ));

  }

  FutureOr<void> _notifyHomeSelected(event, Emitter<RoomState> emit) {
    emit(state.copyWith(
      currentHomeId: event.homeId,
    ));
  }
}
