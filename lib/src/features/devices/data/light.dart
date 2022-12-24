import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/features/devices/data/devices.dart';


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

class Light extends Device {
  Light({required int powerConsumption, String name = 'Light', Color color = Colors.yellow, required int id})
      : super(
            type: DeviceType.light,
            name: name,
            powerConsumption: powerConsumption,
            icon: Icons.lightbulb_outline,
            color: color
            );
}
