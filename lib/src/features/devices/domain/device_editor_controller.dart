import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/core/state_manager/bloc.dart';
import 'package:smarthome_algeria/src/core/state_manager/events.dart';
import 'package:smarthome_algeria/src/features/devices/data/routes_data.dart';
import 'package:smarthome_algeria/src/features/devices/devices_feature.dart';
import 'package:smarthome_algeria/src/features/room/domain/room.dart';

class DeviceEditorController {
  final GlobalKey<FormState> key = GlobalKey();
  final AppBloc appBloc;
  final DeviceEditorData editorSettings;

  String deviceName = "";
  int powerConsumption = 0;
  DeviceType deviceType = DeviceType.light;
  int? roomIndex;
  Room? deviceRoom;

  DeviceEditorController(this.appBloc, this.editorSettings);

  void onDeviceClick(int index, DeviceArchetype device) {
    deviceType = device.type;
  }

  void onSave() {
    if (key.currentState!.validate()) {
      if (editorSettings.isEditMode) {
        appBloc.add(UpdateDevice(
          device: editorSettings.device!,
          index: editorSettings.index!,
          roomIndex: editorSettings.roomIndex!,
        ));
      } else {
        appBloc.add(AddDevice(
            type: deviceType,
            consumption: powerConsumption,
            name: deviceName,
            roomIndex: roomIndex!,));
      }
      AppNavigator.pop();
    }
  }

  void onCancel() {
    AppNavigator.pop();
  }

  void onConsumptionChanged(String? newValue) {
    if (newValue != null) {
      powerConsumption = int.parse(newValue);
    }
  }

  void onConsumptionSelected(int? newValue) {
    if (newValue != null) {
      powerConsumption = newValue;
    }
  }

  void selectRoom(int? index,Room? room) {
    deviceRoom = room;
    roomIndex = index ?? 0;
  }
}
