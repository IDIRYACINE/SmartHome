import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/features/devices/data/device_archetype.dart';
import 'package:smarthome_algeria/src/features/devices/data/devices.dart';
import 'package:smarthome_algeria/src/features/devices/data/routes_data.dart';
import 'package:smarthome_algeria/src/features/room/room_feature.dart';

class DeviceEditorController {
  final GlobalKey<FormState> key = GlobalKey();
  final RoomBloc roomBloc;
  final DeviceEditorData editorSettings;

  String deviceName = "";
  int powerConsumption = 0;
  DeviceType deviceType = DeviceType.light;
  int? roomIndex;
  int? roomId;
  Room? deviceRoom;

  DeviceEditorController(this.roomBloc, this.editorSettings);

  void onDeviceClick(int index, DeviceArchetype device) {
    deviceType = device.type;
  }

  void onSave() {
    if (key.currentState!.validate()) {
      if (editorSettings.isEditMode) {
        roomBloc.add(UpdateDevice(
          device: editorSettings.device!,
          roomIndex: editorSettings.roomIndex!,
          deviceIndex: editorSettings.index!,
        ));
      } else {
        roomBloc.add(AddDevice(
          type: deviceType,
          consumption: powerConsumption,
          name: deviceName,
          homeId: editorSettings.homeId!,
          roomId: roomId!,
          roomIndex: roomIndex!,
        ));
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

  void selectRoom(int? index, Room? room) {
    deviceRoom = room;
    roomId = room?.id;
    roomIndex = index ?? 0;
  }
}
