import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/features/devices/domain/device.dart';


enum LightPowerConsumption { low, medium, high }

extension LightPowerConsumptionExtension on LightPowerConsumption {
  double get powerConsumption {
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
  Light({required double powerConsumption, String name = 'Light', Color color = Colors.yellow})
      : super(
            type: DeviceType.light,
            name: name,
            powerConsumption: powerConsumption,
            icon: Icons.lightbulb_outline,
            color: color
            );
}
