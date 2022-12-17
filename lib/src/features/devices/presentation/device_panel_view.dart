import 'package:flutter/cupertino.dart';
import 'package:smarthome_algeria/src/features/devices/domain/device.dart';
import 'package:smarthome_algeria/src/features/devices/domain/light.dart';
import 'package:smarthome_algeria/src/features/devices/presentation/device_button.dart';

typedef DeviceClickCallback = void Function(Device data);

class DeviceControlPanelView extends StatelessWidget {
  const DeviceControlPanelView({super.key, this.padding = 4, this.onPressed});

  final double padding;
  final int crossAxisCount = 3;
  final DeviceClickCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: crossAxisCount, children: [
      DeviceButton(
          onPressed: (device) {
            onPressed?.call(device);
          },
          device: Light(
              powerConsumption: LightPowerConsumption.low.powerConsumption))
    ]);
  }
}
