import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/features/devices/presentation/device_panel_view.dart';
import 'package:smarthome_algeria/src/features/room/domain/room.dart';
import 'package:smarthome_algeria/src/features/room/presentation/room_preview_widget.dart';
import 'widgets.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  Room getRoom(int roomIndex) {
    // TODO : implement this method
    return Room(name: "name", id: 1, deviceIds: [1, 2, 3, 4]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: DashboardAppBar(),
          ),
          Flexible(
            child: ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: const DeviceControlPanelView()),
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
      ),
    );
  }
}
