import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_algeria/src/features/devices/data/devices.dart';
import 'package:smarthome_algeria/src/features/room/state/events.dart';
import 'package:smarthome_algeria/src/features/room/state/state.dart';

class RoomBloc extends Bloc<RoomEvents, RoomState> {
  RoomBloc({RoomState? initialState})
      : super(initialState ?? RoomState.initialState()) {
    on<AddDevice>(_addDevice);
    on<UpdateDevice>(_updateDevice);
    on<RemoveDevice>(_removeDevice);
  }

  void _addDevice(AddDevice event, Emitter<RoomState> emit) {
    final List<Device> source = state.getDeviceList(event.type);
    final List<Device> updatedDevices = List.from(source);

    int index = updatedDevices.length;
    Device device =
        Device.build(event.type, event.consumption, index, event.name);

    updatedDevices.add(device);

    emit(state.copyWithDeviceType(event.type, updatedDevices));
  }

  void _updateDevice(UpdateDevice event, Emitter<RoomState> emit) {
    final List<Device> source = state.getDeviceList(event.device.type);
    final List<Device> updatedDevices = List.from(source);

    updatedDevices[event.index] = event.device;
    emit(state.copyWithDeviceType(event.device.type, updatedDevices));
  }

  void _removeDevice(RemoveDevice event, Emitter<RoomState> emit) {
    final List<Device> source = state.getDeviceList(event.device.type);
    final List<Device> updatedDevices = List.from(source);

    updatedDevices.remove(event.device);

    emit(state.copyWithDeviceType(event.device.type, updatedDevices));
  }
}
