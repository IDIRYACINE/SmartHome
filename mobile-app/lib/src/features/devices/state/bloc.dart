import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_algeria/src/features/devices/data/devices.dart';
import 'package:smarthome_algeria/src/services/localDatabase/service.dart';
import 'package:smarthome_algeria/src/services/servicesProvider/services.dart';

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

    _removeDeviceOnDatabase(event.device);

    emit(newState);
  }

  FutureOr<void> _updateDevice(UpdateDevice event, Emitter<DevicesState> emit) {
    List<Device> updatedDevices = List.from(state
        .getDeviceListByType(event.device.type)
        .where((device) => device.uniqueId != event.device.uniqueId));

    DevicesState newState =
        state.copyWithDeviceType(event.device.type, updatedDevices);

    _updateDeviceOnDatabase(event.device);

    emit(newState);
  }

  FutureOr<void> _addDevice(AddDevice event, Emitter<DevicesState> emit) {
    List<Device> updatedDevices = List.from(
        state.getDeviceListByType(event.device.type)..add(event.device));

    DevicesState newState =
        state.copyWithDeviceType(event.device.type, updatedDevices);

    _addDeviceOnDatabase(event.device);

    emit(newState);
  }

  void _updateDeviceOnDatabase(Device device) {
    ServiceMessage message =
        DatabaseMessageBuilder.updateDeviceMessage(device, () {});
    ServicesProvider.instance.sendMessage(message);
  }

  void _addDeviceOnDatabase(Device device) {
    ServiceMessage message =
        DatabaseMessageBuilder.addDeviceMessage(device, () {});
    ServicesProvider.instance.sendMessage(message);
  }

  void _removeDeviceOnDatabase(Device device) {
    ServiceMessage message =
        DatabaseMessageBuilder.deleteDeviceMessage(device, () {});
    ServicesProvider.instance.sendMessage(message);
  }
}
