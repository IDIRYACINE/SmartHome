import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/features/devices/data/devices.dart';

import '../data/type_aliases.dart';

class DevicePreviewCard extends StatefulWidget {
  const DevicePreviewCard({super.key, required this.device, this.onTap, required this.onLongPress, required this.index});

  final Device device;
  final int index;
  final DeviceTap? onTap;
  final DeviceLongPress onLongPress;


  @override
  State<StatefulWidget> createState() => _DevicePreviewCardState();
}

class _DevicePreviewCardState extends State<DevicePreviewCard> {
  bool? isOn;

  @override
  Widget build(BuildContext context) {
    isOn ??= widget.device.isOn;
    final theme = Theme.of(context);

    Color tileColor = isOn! ? theme.colorScheme.primaryContainer : theme.cardColor;

    return GestureDetector(
      onLongPress: () => widget.onLongPress(widget.device,widget.index),
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
          ),
          title: Text(widget.device.name),
        ),
      ),
    );
  }
}
