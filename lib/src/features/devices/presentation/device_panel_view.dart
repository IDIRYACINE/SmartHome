import 'package:flutter/cupertino.dart';
import 'package:smarthome_algeria/src/features/devices/domain/light.dart';
import 'package:smarthome_algeria/src/features/devices/presentation/device_button.dart';

class DeviceControlPanelView extends StatelessWidget {
  const DeviceControlPanelView({super.key, this.padding = 4});

  final double padding;
  final int crossAxisCount = 3;

  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: crossAxisCount, children: [
      DeviceButton(
          onPressed: () {},
          device: Light(
              powerConsumption: LightPowerConsumption.low.powerConsumption))
    ]);
  }
}
