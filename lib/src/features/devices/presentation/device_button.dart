
import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/features/devices/domain/device.dart';
import 'package:smarthome_algeria/src/features/devices/presentation/device_label.dart';

class DeviceButton extends StatelessWidget{
  const DeviceButton({super.key, required this.onPressed, required this.device});

  final VoidCallback onPressed;
  final Device device;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: RoundDeviceLabel(device: device,)
    );
  }
}