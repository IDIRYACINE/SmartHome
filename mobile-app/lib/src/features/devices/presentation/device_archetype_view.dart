import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smarthome_algeria/src/features/devices/devices_feature.dart';

class DeviceArchetypeView extends StatelessWidget {
  const DeviceArchetypeView({super.key, required this.deviceArchetype});

  final DeviceArchetype deviceArchetype;

  @override
  Widget build(BuildContext context) {
    final devices = BlocProvider.of<DevicesBloc>(context)
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
            Text(deviceArchetype.name,
                style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  return DevicePreviewCard(
                      device: devices[index],
                      onLongPress: (device, key) => {},
                      index: index);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 5,
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
