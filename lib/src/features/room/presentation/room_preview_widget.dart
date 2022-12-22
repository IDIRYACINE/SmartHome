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
    return Light(powerConsumption: 70);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final displayedDevicesCount =
        room.deviceIds.length > maxDevices ? maxDevices : room.deviceIds.length;

    return ConstrainedBox(
      constraints:  BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Text(
                room.name,
                style: textTheme.displaySmall,
              ),
              Text(
                "${room.deviceIds.length} ${AppLocalizations.of(context)!.devices}",
                style: textTheme.bodyMedium!.copyWith(color: Colors.grey),
              ),
            ]),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            delegate: SliverChildBuilderDelegate(
              childCount: displayedDevicesCount,
              (context, index) {
                return DevicePreviewCard(
                  device: getDevice(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
