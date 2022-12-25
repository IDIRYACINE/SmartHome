import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smarthome_algeria/src/features/devices/devices_feature.dart';
import 'package:smarthome_algeria/src/features/room/room_feature.dart';

class DeviceArchetypeView extends StatelessWidget {
  const DeviceArchetypeView({super.key, required this.deviceArchetype});

  final DeviceArchetype deviceArchetype;

  @override
  Widget build(BuildContext context) {
    final devices = BlocProvider.of<RoomBloc>(context)
        .state
        .getArchetypeDeviceList(deviceArchetype);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.devices),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(deviceArchetype.name , style:Theme.of(context).textTheme.displaySmall),

            Expanded(
              child: ListView.builder(
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(devices[index].name),
                    subtitle: Text(devices[index].id.toString()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

