import 'package:flutter/material.dart';

enum DeviceType {
  light,
  plug,
  lock,
}

extension DeviceTypeExtension on DeviceType {
  String get deviceType {
    switch (this) {
      case DeviceType.light:
        return 'light';
      case DeviceType.plug:
        return 'plug';
      case DeviceType.lock:
        return 'lock';
      default:
        return 'unknown';
    }
  }
}

class Device {
  DeviceType type;
  String name;
  int powerConsumption;
  IconData icon;
  bool isOn;

  Color color;
  int id;
  int roomId;
  int homeId;

  // this is used to identify the device quickly in the devicesState
  // it is not used in the database
  // don't manipulate this value
  final int uniqueId = _uniqueId;
  static int _uniqueId = 0;

  Device({
    required this.type,
    required this.name,
    required this.powerConsumption,
    required this.icon,
    this.isOn = false,
    this.color = Colors.white,
    required this.id,
    this.roomId = 0,
    this.homeId = 0,
  }){
    _uniqueId++;
  }


}


const defaultLightConsumptions = [
  40,
  45,
  50,
  55,
  60,
  65,
  70,
  75,
  80,
 
];


const defaultPlugConsumptions = [
  10,
  15,
  20,
  25,
  30,
  35,
  40,
  45,
  50,
];

const defaultLockConsumptions = [
  5,
  10,
  15,
  20,
  25,
  30,
  35,
  40,
  45,
];


// Important to keep the order of the lists as in the DeviceType enum
const List<List<int>> defaultDeviceConsumptions = [
  defaultLightConsumptions,
  defaultPlugConsumptions,
  defaultLockConsumptions,
];


const List<IconData> devicesIcons = [
  Icons.lightbulb,
  Icons.power,
  Icons.lock,
];

enum LightPowerConsumption { low, medium, high }

extension LightPowerConsumptionExtension on LightPowerConsumption {
  int get powerConsumption {
    switch (this) {
      case LightPowerConsumption.low:
        return 10;
      case LightPowerConsumption.medium:
        return 20;
      case LightPowerConsumption.high:
        return 30;
    }
  }
}
