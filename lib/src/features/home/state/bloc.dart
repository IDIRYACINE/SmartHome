import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_algeria/src/features/home/domain/home.dart';
import 'package:smarthome_algeria/src/features/home/state/events.dart';
import 'package:smarthome_algeria/src/features/home/state/state.dart';
import 'package:smarthome_algeria/src/features/room/state/bloc.dart';
import 'package:smarthome_algeria/src/features/room/state/events.dart';

class HomeBloc extends Bloc<HomeEvents, HomeState> {
  final RoomBloc roomBloc;

  HomeBloc(this.roomBloc, {HomeState? initialState})
      : super(initialState ?? HomeState.initialState()) {
    on<AddHome>(_addHome);
    on<UpdateHome>(_updateHome);
    on<RemoveHome>(_removeHome);
    on<SelectHome>(_selectHome);
  }

  void _addHome(AddHome event, Emitter<HomeState> emit) {
    final List<Home> updatedHomes = List.from(state.homes);

    int index = updatedHomes.length;
    Home home = Home(id: index, name: event.homeName, index: index);

    updatedHomes.add(home);

    roomBloc.add(AddHomeGroup(index));

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

    roomBloc.add(RemoveHomeGroup(event.index));

    emit(HomeState(homes: updatedHomes));
  }

  void _selectHome(SelectHome event, Emitter<HomeState> emit) {
    emit(HomeState(homes: state.homes, currentHomeIndex: event.home.index));
  }
}
