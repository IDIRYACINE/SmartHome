
import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/features/devices/domain/device.dart';
import 'package:smarthome_algeria/src/features/devices/presentation/device_label.dart';

typedef DeviceClickCallback = void Function(Device data);

class DeviceButton<T> extends StatelessWidget{
  const DeviceButton({super.key, required this.onPressed, required this.device});

  final DeviceClickCallback onPressed;
  final Device device;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => onPressed(device)),
      child: RoundDeviceLabel(device: device,)
    );
  }
}