import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/features/devices/domain/device.dart';
import 'package:smarthome_algeria/src/features/devices/domain/light.dart';
import 'package:smarthome_algeria/src/features/devices/presentation/device_panel_view.dart';
import 'package:smarthome_algeria/src/features/room/domain/room.dart';
import 'package:smarthome_algeria/src/features/room/presentation/room_preview_widget.dart';

import 'dashboard_label.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  Room getRoom(int roomIndex) {
    return Room(name: "name", id: 1, deviceIds: [1, 2, 3, 4]);
  }

  void onDeviceTap(DeviceType deviceType) {
    AppNavigator.displayDialog(_SelectDevicePopup(deviceType),
        barrierColor: Colors.grey.withOpacity(0.75));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: ColoredBox(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: const HomeLabel(),
          ),
        ),
        Flexible(
          child: ColoredBox(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: DeviceControlPanelView(
                onPressed: (device) => onDeviceTap(device.type),
              )),
        ),
        Flexible(
          flex: 2,
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return RoomPreviewWidget(room: getRoom(index));
            },
          ),
        ),
      ],
    );
  }
}

class _SelectDevicePopup extends StatelessWidget {
  const _SelectDevicePopup(this.device);

  final DeviceType device;

  void onDeviceSelected(int index) {
    AppNavigator.pop(device);
  }

  Widget buildActionEntry(BuildContext context, Device device) {
    return GestureDetector(
      onTap: () => onDeviceSelected(0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Action",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Device> devices = [
      Light(name: "Offic light", id: 1, powerConsumption: 45),
      Light(name: "Office door light", id: 1, powerConsumption: 45)
    ];

    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: SizedBox(
        height: 300,
        width: 500,
        child: ListView.separated(
            itemBuilder: (context, index) =>
                buildActionEntry(context, devices[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 8.0),
            itemCount: devices.length),
      ),
    );
  }
}
