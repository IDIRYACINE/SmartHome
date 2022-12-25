import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/features/devices/data/devices.dart';
import 'package:smarthome_algeria/src/features/devices/data/routes_data.dart';
import 'package:smarthome_algeria/src/features/devices/devices_feature.dart';
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
    // final displayedDevicesCount =
    //     room.devices.length > maxDevices ? maxDevices : room.devices.length;

    // return displayedDevicesCount == 0
    //     ? _NormalPreviewView(
    //         roomDevicesCount: room.devices.length,
    //         roomName: room.name,
    //         displayedDevicesCount: displayedDevicesCount,
    //         getDevice: getDevice,
    //       )
    //     : const _EmptyPreviewView();

    return _NormalPreviewView(
      roomDevicesCount: 4,
      roomName: "Test",
      displayedDevicesCount: 4,
      getDevice: (index) => Light(powerConsumption: 44, id: 55),
    );
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

  void onDeviceLongPress(Device device, int index) {
    DeviceEditorData data = DeviceEditorData(
      device: device,
      index: index,
      isEditMode: true,
    );

    AppNavigator.pushNamed(deviceEditorRoute, arguments: data);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ColoredBox(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            roomName,
            style: textTheme.displaySmall,
          ),
          Text(
            "$roomDevicesCount ${AppLocalizations.of(context)!.devices}",
            style: textTheme.bodyMedium!.copyWith(color: Colors.grey),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 8,
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                ),
                itemCount: displayedDevicesCount,
                itemBuilder: (context, index) {
                  return DevicePreviewCard(
                    device: getDevice(index),
                    onLongPress: onDeviceLongPress,
                    index: index,
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class _EmptyPreviewView extends StatelessWidget {
  const _EmptyPreviewView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Text(AppLocalizations.of(context)!.noDevices),
      ],
    );
  }
}
