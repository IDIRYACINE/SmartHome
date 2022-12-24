import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/features/devices/data/routes_data.dart';
import 'package:smarthome_algeria/src/features/devices/devices_feature.dart';
import 'package:smarthome_algeria/src/features/room/room_feature.dart';

class DeviceEditorController {
  final GlobalKey<FormState> key = GlobalKey();
  final RoomBloc roomBloc;
  final DeviceEditorData editorSettings;

  String deviceName = "";
  int powerConsumption = 0;
  DeviceType deviceType = DeviceType.light;
  Room? deviceRoom;

  DeviceEditorController(this.roomBloc, this.editorSettings);

  void onDeviceClick(Device device) {
    deviceType = device.type;
  }

  void onSave() {
    if (key.currentState!.validate()) {
      if (editorSettings.isEditMode) {
        roomBloc.add(UpdateDevice(
            editorSettings.device!, editorSettings.index!));
      } else {
        roomBloc.add(AddDevice(deviceType, powerConsumption, deviceName));
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

  void selectRoom(Room? room) {
    deviceRoom = room;
  }
}
