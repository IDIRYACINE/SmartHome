
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_algeria/src/features/devices/data/devices.dart';
import 'package:smarthome_algeria/src/features/room/domain/room.dart';
import 'package:smarthome_algeria/src/features/room/state/events.dart';
import 'package:smarthome_algeria/src/features/room/state/state.dart';

class RoomBloc extends Bloc<RoomEvents, RoomState> {
  RoomBloc({RoomState? initialState})
      : super(initialState ?? RoomState.initialState()) {
    on<AddDevice>(_addDevice);
    on<UpdateDevice>(_updateDevice);
    on<RemoveDevice>(_removeDevice);
    on<SelectCurrentHome>(_selectCurrentHome);
  }

  void _addDevice(AddDevice event, Emitter<RoomState> emit) {

    final List<RoomGroup> updatedGroups = List.from(state.roomGroups);
    final RoomGroup sourceGroup = updatedGroups[state.roomGroup!.homeId];
    final Room sourceRoom = sourceGroup.rooms[event.roomIndex];

    int deviceId = sourceRoom.devices.length;

    final Device device = Device(
        id: deviceId,
        name: event.name,
        powerConsumption: event.consumption,
        type: event.type,
        icon: devicesIcons[event.type.index]);

    sourceRoom.devices.add(device);
    sourceRoom.getDeviceList(event.type).add(device);

    emit(state.copyWith(roomGroups: updatedGroups));
  }

  void _updateDevice(UpdateDevice event, Emitter<RoomState> emit) {
    int roomGroupIndex = state.roomGroups.indexOf(state.roomGroup!);
    final List<RoomGroup> updatedGroups = List.from(state.roomGroups);

    final RoomGroup sourceGroup = updatedGroups[roomGroupIndex];
    final Room sourceRoom = sourceGroup.rooms[event.roomIndex];

    sourceRoom.devices[event.index] = event.device;

    List<Device> deviceTypeList = sourceRoom.getDeviceList(event.device.type);
    int deviceTypeIndex = deviceTypeList.indexOf(event.device);
    deviceTypeList[deviceTypeIndex] = event.device;

    emit(state.copyWith(roomGroups: updatedGroups));
  }

  void _removeDevice(RemoveDevice event, Emitter<RoomState> emit) {
    int roomGroupIndex = state.roomGroups.indexOf(state.roomGroup!);
    final List<RoomGroup> updatedGroups = List.from(state.roomGroups);

    final RoomGroup sourceGroup = updatedGroups[roomGroupIndex];
    final Room sourceRoom = sourceGroup.rooms[event.roomIndex];

    List<Device> deviceTypeList = sourceRoom.getDeviceList(event.device.type);

    sourceRoom.devices.remove(event.device);
    deviceTypeList.remove(event.device);

    emit(state.copyWith(roomGroups: updatedGroups));
  }

  void _selectCurrentHome(SelectCurrentHome event, Emitter<RoomState> emit) {
    emit(state.copyWith(currentHomeId: event.homeId));
  }
}
