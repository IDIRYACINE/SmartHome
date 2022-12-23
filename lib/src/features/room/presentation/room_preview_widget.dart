import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/features/devices/domain/device.dart';
import 'package:smarthome_algeria/src/features/devices/domain/light.dart';
import 'package:smarthome_algeria/src/features/devices/presentation/device_preview_card.dart';

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
    // TODO : implement this method
    return Light(powerConsumption: 70, id: 7);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final displayedDevicesCount =
        room.deviceIds.length > maxDevices ? maxDevices : room.deviceIds.length;

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(
        width: double.infinity,
        child: ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: Text(
              room.name,
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
              "${room.deviceIds.length} ${AppLocalizations.of(context)!.devices}",
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
