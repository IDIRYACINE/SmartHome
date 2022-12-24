
import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/features/devices/data/devices.dart';

class DeviceLabel extends StatelessWidget {
  const DeviceLabel({super.key, required this.device});

  final Device device;

  @override
  Widget build(BuildContext context) {

    return 
        Container(
          color: device.color,
          child: Row(
            children: [
               Icon(device.icon),
              Text(
                device.type.deviceType,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        );
      
    
  }
}

class RoundDeviceLabel extends StatelessWidget{
  const RoundDeviceLabel({super.key, required this.device,  this.space = 4});

  final Device device;
  final double space; 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: device.color,
            shape: BoxShape.circle,
          ),
          child: Icon(device.icon),
        ),
        SizedBox(height: space),
        Text(
          device.type.deviceType,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}