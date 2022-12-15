import 'package:flutter/material.dart';
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

abstract class Device {
  DeviceType type;
  String name;
  double powerConsumption;
  IconData icon;

  Color color;
  int? id;
  int? index;

  Device({
    required this.type,
    required this.name,
    required this.powerConsumption,
    required this.icon,
    required this.color,
  });

}
