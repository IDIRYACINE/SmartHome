import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/core/state_manager/bloc.dart';
import 'package:smarthome_algeria/src/core/state_manager/state.dart';
import 'package:smarthome_algeria/src/features/devices/data/routes_data.dart';
import 'package:smarthome_algeria/src/features/devices/devices_feature.dart';
import 'package:smarthome_algeria/src/features/room/domain/type_aliases.dart';
import '../domain/room.dart';

class RoomPreviewWidget extends StatelessWidget {
  const RoomPreviewWidget({
    super.key,
    required this.roomIndex,
    this.maxDevices = 4,
  });

  final int roomIndex;
  final int maxDevices;

  Device getDevice(Room room, int deviceId) {
    return room.devices.firstWhere((device) => device.id == deviceId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      final room = state.rooms[roomIndex];
      final int roomDevicesCount = room.devices.length;
      final textTheme = Theme.of(context).textTheme;

      return Column(
        children: [
          Text(
            room.name,
            style: textTheme.displaySmall,
          ),
          Text(
            "$roomDevicesCount ${AppLocalizations.of(context)!.devices}",
            style: textTheme.bodyMedium!.copyWith(color: Colors.grey),
          ),
          room.devices.isNotEmpty
              ? _NormalPreviewView(
                  roomDevicesCount: roomDevicesCount,
                  roomName: room.name,
                  displayedDevicesCount: roomDevicesCount,
                  roomIndex: roomIndex,
                  getDevice: (deviceIndex) => getDevice(room, deviceIndex),
                )
              : const _EmptyPreviewView(),
        ],
      );
    });
  }
}

class _NormalPreviewView extends StatelessWidget {
  const _NormalPreviewView(
      {required this.displayedDevicesCount,
      required this.roomName,
      required this.roomIndex,
      required this.roomDevicesCount,
      required this.getDevice});

  final int displayedDevicesCount;
  final String roomName;
  final int roomDevicesCount;
  final FetchDevice getDevice;
  final int roomIndex;

  void onDeviceLongPress(Device device, int index) {
    DeviceEditorData data = DeviceEditorData(
      device: device,
      index: index,
      roomIndex: roomIndex,
      isEditMode: true,
    );

    AppNavigator.pushNamed(deviceEditorRoute, arguments: data);
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
