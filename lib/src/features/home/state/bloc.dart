import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_algeria/src/features/home/domain/home.dart';
import 'package:smarthome_algeria/src/features/home/state/events.dart';
import 'package:smarthome_algeria/src/features/home/state/state.dart';
import 'package:smarthome_algeria/src/features/room/domain/room.dart';

class HomeBloc extends Bloc<HomeEvents, HomeState> {
  HomeBloc({HomeState? initialState})
      : super(initialState ?? HomeState.initialState()) {
    on<AddHome>(_addHome);
    on<UpdateHome>(_updateHome);
    on<RemoveHome>(_removeHome);
    on<SelectHome>(_selectHome);

    on<AddRoom>(_addRoom);
    on<UpdateRoom>(_updateRoom);
    on<RemoveRoom>(_removeRoom);
  }

  void _addHome(AddHome event, Emitter<HomeState> emit) {
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

  void _updateHome(UpdateHome event, Emitter<HomeState> emit) {
    final List<Home> updatedHomes = List.from(state.homes);
    updatedHomes[event.index] = event.home;
    emit(HomeState(homes: updatedHomes));
  }

  void _removeHome(RemoveHome event, Emitter<HomeState> emit) {
    final List<Home> updatedHomes = List.from(state.homes);
    updatedHomes.removeAt(event.index);
    emit(HomeState(homes: updatedHomes));
  }

  void _selectHome(SelectHome event, Emitter<HomeState> emit) {
    emit(HomeState(homes: state.homes, currentHomeIndex: event.home.index));
  }

  void _addRoom(AddRoom event, Emitter<HomeState> emit) {
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

  void _updateRoom(UpdateRoom event, Emitter<HomeState> emit) {
    final List<Room> updatedRooms = List.from(state.rooms);

    updatedRooms[event.index] = event.room;

    final List<Home> updatedHomes = List.from(state.homes);
    int homeIndex = state.currentHome!.index;

    updatedHomes[homeIndex] =
        updatedHomes[homeIndex].copyWith(rooms: updatedRooms);

    emit(state.copyWith(homes: updatedHomes));
  }

  void _removeRoom(RemoveRoom event, Emitter<HomeState> emit) {
    final List<Room> updatedRooms = List.from(state.rooms);

    updatedRooms.remove(event.room);

    final List<Home> updatedHomes = List.from(state.homes);
    int homeIndex = state.currentHome!.index;

    updatedHomes[homeIndex] =
        updatedHomes[homeIndex].copyWith(rooms: updatedRooms);

    emit(state.copyWith(homes: updatedHomes));
  }
}
