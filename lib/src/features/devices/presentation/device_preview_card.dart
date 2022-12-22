import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/features/devices/domain/device.dart';

typedef DeviceCallback = void Function(Device device);

class DevicePreviewCard extends StatefulWidget {
  const DevicePreviewCard({super.key, required this.device, this.onTap});

  final Device device;
  final DeviceCallback? onTap;

  @override
  State<StatefulWidget> createState() => _DevicePreviewCardState();
}

class _DevicePreviewCardState extends State<DevicePreviewCard> {
  bool? isOn;

  @override
  Widget build(BuildContext context) {
    isOn ??= widget.device.isOn;

    Color tileColor = isOn! ? widget.device.color : Colors.grey;

    return GestureDetector(
      onTap: () {
        setState(() {
          isOn = !isOn!;
        });
        widget.onTap?.call(widget.device);
      },
      child: Center(
        child: ListTile(
          tileColor: tileColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          leading: Icon(
            widget.device.icon,
            color: Colors.black,
          ),
          title: Text(widget.device.name),
        ),
      ),
    );
  }
}
