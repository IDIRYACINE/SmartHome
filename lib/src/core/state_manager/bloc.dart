import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_algeria/src/core/state_manager/app_bloc.dart';
import 'package:smarthome_algeria/src/features/devices/data/devices.dart';
import 'package:smarthome_algeria/src/features/home/domain/home.dart';
import 'package:smarthome_algeria/src/features/room/domain/room.dart';

class AppBloc extends Bloc<AppEvents, AppState> {
  AppBloc({AppState? initialState})
      : super(initialState ?? AppState.initialState()) {
    on<AddHome>(_addHome);
    on<UpdateHome>(_updateHome);
    on<RemoveHome>(_removeHome);
    on<SelectHome>(_selectHome);

    on<AddRoom>(_addRoom);
    on<UpdateRoom>(_updateRoom);
    on<RemoveRoom>(_removeRoom);

    on<AddDevice>(_addDevice);
    on<UpdateDevice>(_updateDevice);
    on<RemoveDevice>(_removeDevice);
  }

  void _addHome(AddHome event, Emitter<AppState> emit) {
    final List<Home> updatedHomes = List.from(state.homes);

    int index = updatedHomes.length;
    Home home = Home(id: index, name: event.homeName, index: index);

    updatedHomes.add(home);

    if (index == 0) {
      emit(state.copyWith(homes: updatedHomes, currentHomeIndex: index));
      return;
    }
    emit(state.copyWith(homes: updatedHomes));
  }

  void _updateHome(UpdateHome event, Emitter<AppState> emit) {
    final List<Home> updatedHomes = List.from(state.homes);
    updatedHomes[event.index] = event.home;
    emit(AppState(homes: updatedHomes));
  }

  void _removeHome(RemoveHome event, Emitter<AppState> emit) {
    final List<Home> updatedHomes = List.from(state.homes);
    updatedHomes.removeAt(event.index);
    emit(AppState(homes: updatedHomes));
  }

  void _selectHome(SelectHome event, Emitter<AppState> emit) {
    emit(AppState(homes: state.homes, currentHomeIndex: event.home.index));
  }

  void _addRoom(AddRoom event, Emitter<AppState> emit) {
    final List<Room> updatedRooms = List.from(state.rooms);

    int index = state.rooms.length;
    Room room = Room(id: index, name: event.roomName, devices: []);

    updatedRooms.add(room);

    final List<Home> updatedHomes = List.from(state.homes);
    int homeIndex = state.currentHome!.index;

    updatedHomes[homeIndex] =
        updatedHomes[homeIndex].copyWith(rooms: updatedRooms);

    emit(state.copyWith(homes: updatedHomes));
  }

  void _updateRoom(UpdateRoom event, Emitter<AppState> emit) {
    final List<Room> updatedRooms = List.from(state.rooms);

    updatedRooms[event.index] = event.room;

    final List<Home> updatedHomes = List.from(state.homes);
    int homeIndex = state.currentHome!.index;

    updatedHomes[homeIndex] =
        updatedHomes[homeIndex].copyWith(rooms: updatedRooms);

    emit(state.copyWith(homes: updatedHomes));
  }

  void _removeRoom(RemoveRoom event, Emitter<AppState> emit) {
    final List<Room> updatedRooms = List.from(state.rooms);

    updatedRooms.remove(event.room);

    final List<Home> updatedHomes = List.from(state.homes);
    int homeIndex = state.currentHome!.index;

    updatedHomes[homeIndex] =
        updatedHomes[homeIndex].copyWith(rooms: updatedRooms);

    emit(state.copyWith(homes: updatedHomes));
  }

  void _addDevice(AddDevice event, Emitter<AppState> emit) {
    final List<Room> updatedRooms = List.from(state.rooms);

    Room updatedRoom = updatedRooms[event.roomIndex];

    int deviceId = updatedRoom.devices.length;

    final Device device = Device(
        id: deviceId,
        name: event.name,
        powerConsumption: event.consumption,
        type: event.type,
        icon: devicesIcons[event.type.index]);

    List<Device> updatedDevices =
        List.from(updatedRoom.getDeviceList(event.type));
    List<Device> updatedAllDevices = List.from(updatedRoom.devices);

    updatedAllDevices.add(device);
    updatedDevices.add(device);

    updatedRoom = updatedRoom.copyWithDeviceType(
      type: device.type,
      updatedDevices: updatedDevices,
      updatedAllDevice: updatedAllDevices,
    );

    updatedRooms[event.roomIndex] = updatedRoom;

    final List<Home> updatedHomes = List.from(state.homes);
    int homeIndex = state.currentHome!.index;

    updatedHomes[homeIndex] =
        updatedHomes[homeIndex].copyWith(rooms: updatedRooms);

    emit(state.copyWith(homes: updatedHomes));
  }

  void _updateDevice(UpdateDevice event, Emitter<AppState> emit) {
    final List<Room> updatedRooms = List.from(state.rooms);

    Room updatedRoom = updatedRooms[event.roomIndex];

    int deviceIndex = updatedRoom.devices.indexOf(event.device);
    int deviceTypeIndex =
        updatedRoom.getDeviceList(event.device.type).indexOf(event.device);

    List<Device> updatedDevices =
        List.from(updatedRoom.getDeviceList(event.device.type));
    List<Device> updatedAllDevices = List.from(updatedRoom.devices);

    updatedDevices[deviceTypeIndex] = event.device;
    updatedAllDevices[deviceIndex] = event.device;

    updatedRoom = updatedRoom.copyWithDeviceType(
      type: event.device.type,
      updatedDevices: updatedDevices,
      updatedAllDevice: updatedAllDevices,
    );
    
updatedRooms[event.roomIndex] = updatedRoom;

    final List<Home> updatedHomes = List.from(state.homes);
    int homeIndex = state.currentHome!.index;

    updatedHomes[homeIndex] =
        updatedHomes[homeIndex].copyWith(rooms: updatedRooms);

    emit(state.copyWith(homes: updatedHomes));
  }

  void _removeDevice(RemoveDevice event, Emitter<AppState> emit) {
    final List<Room> updatedRooms = List.from(state.rooms);

    Room updatedRoom = updatedRooms[event.roomIndex];

    updatedRoom.devices.remove(event.device);
    updatedRoom.getDeviceList(event.device.type).remove(event.device);

    final List<Home> updatedHomes = List.from(state.homes);
    int homeIndex = state.currentHome!.index;

    updatedHomes[homeIndex] =
        updatedHomes[homeIndex].copyWith(rooms: updatedRooms);

    emit(state.copyWith(homes: updatedHomes));
  }
}
