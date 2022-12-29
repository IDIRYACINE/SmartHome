import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_algeria/src/features/devices/data/devices.dart';

import 'events.dart';
import 'state.dart';

class DevicesBloc extends Bloc<DeviceEvent, DevicesState> {
  DevicesBloc({DevicesState? initialState})
      : super(initialState ?? DevicesState.initialState()) {
    on<AddDevice>(_addDevice);
    on<UpdateDevice>(_updateDevice);
    on<RemoveDevice>(_removeDevice);
  }

  FutureOr<void> _removeDevice(RemoveDevice event, Emitter<DevicesState> emit) {
    List<Device> updatedDevices = List.from(state
        .getDeviceListByType(event.device.type)
        .where((device) => device.uniqueId != event.device.uniqueId));

    DevicesState newState =
        state.copyWithDeviceType(event.device.type, updatedDevices);

    emit(newState);
  }

  FutureOr<void> _updateDevice(UpdateDevice event, Emitter<DevicesState> emit) {
    List<Device> updatedDevices = List.from(state
        .getDeviceListByType(event.device.type)
        .where((device) => device.uniqueId != event.device.uniqueId));

    DevicesState newState =
        state.copyWithDeviceType(event.device.type, updatedDevices);
    emit(newState);
  }

  FutureOr<void> _addDevice(AddDevice event, Emitter<DevicesState> emit) {
    List<Device> updatedDevices = List.from(
        state.getDeviceListByType(event.device.type)..add(event.device));

    DevicesState newState =
        state.copyWithDeviceType(event.device.type, updatedDevices);

    emit(newState);
  }
}
