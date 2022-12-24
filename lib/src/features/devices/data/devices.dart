import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/features/devices/data/light.dart';

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

abstract class Device {
  DeviceType type;
  String name;
  int powerConsumption;
  IconData icon;
  bool isOn;

  Color color;
  int? id;
  int? index;

  Device({
    required this.type,
    required this.name,
    required this.powerConsumption,
    required this.icon,
    required this.color,
    this.isOn = false, 
  });

  static Device build(DeviceType type, int consumption,int id, String name) {
    return Light(powerConsumption: consumption, id: id);
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