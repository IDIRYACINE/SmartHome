import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/features/devices/domain/device.dart';
import 'package:smarthome_algeria/src/features/devices/presentation/device_preview_card.dart';
import 'package:smarthome_algeria/src/features/room/domain/type_aliases.dart';
import '../domain/room.dart';

class RoomPreviewWidget extends StatelessWidget {
  const RoomPreviewWidget({
    super.key,
    required this.room,
    this.maxDevices = 4,
  });

  final Room room;
  final int maxDevices;

  Device getDevice(int deviceId) {
    return room.devices.firstWhere((device) => device.id == deviceId);
  }

  @override
  Widget build(BuildContext context) {
    final displayedDevicesCount =
        room.devices.length > maxDevices ? maxDevices : room.devices.length;

    return displayedDevicesCount == 0
        ? _NormalPreviewView(
            roomDevicesCount: room.devices.length,
            roomName: room.name,
            displayedDevicesCount: displayedDevicesCount,
            getDevice: getDevice,
          )
        : const _EmptyPreviewView();
  }
}

class _NormalPreviewView extends StatelessWidget {
  const _NormalPreviewView(
      {required this.displayedDevicesCount,
      required this.roomName,
      required this.roomDevicesCount,
      required this.getDevice});

  final int displayedDevicesCount;
  final String roomName;
  final int roomDevicesCount;
  final FetchDevice getDevice;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(
        width: double.infinity,
        child: ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: Text(
              roomName,
              style: textTheme.displaySmall,
            ),
          ),
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: Text(
              "$roomDevicesCount ${AppLocalizations.of(context)!.devices}",
              style: textTheme.bodyMedium!.copyWith(color: Colors.grey),
            ),
          ),
        ),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width,
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 8,
              crossAxisCount: 2,
              childAspectRatio: 4,
            ),
            itemCount: displayedDevicesCount,
            itemBuilder: (context, index) {
              return DevicePreviewCard(
                device: getDevice(index),
              );
            }),
      ),
    ]);
  }
}

class _EmptyPreviewView extends StatelessWidget {
  const _EmptyPreviewView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        const SizedBox(
          height: 8,
        ),
        Text(AppLocalizations.of(context)!.noDevices),
      ],
    );
  }
}
