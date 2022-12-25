
import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/features/devices/data/devices.dart';

class DeviceArchetype {
  final DeviceType type;
  final IconData icon;
  final String name;

  DeviceArchetype(this.type, this.icon, this.name);
}

class LightArchetype extends DeviceArchetype {
  LightArchetype() : super(DeviceType.light, Icons.lightbulb, 'Lighting');
}

class PlugArchetype extends DeviceArchetype {
  PlugArchetype() : super(DeviceType.plug, Icons.power, 'Plug');
}

class LockArchetype extends DeviceArchetype {
  LockArchetype() : super(DeviceType.lock, Icons.lock, 'Lock');
}


final deviceArchetypes = [
  LightArchetype(),
  PlugArchetype(),
  LockArchetype(),
];