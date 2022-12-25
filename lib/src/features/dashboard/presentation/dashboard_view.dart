import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/features/dashboard/presentation/dashboard_rooms_listview.dart';
import 'package:smarthome_algeria/src/features/devices/devices_feature.dart';
import 'package:smarthome_algeria/src/features/home/home_feature.dart';
import 'package:smarthome_algeria/src/features/room/room_feature.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  void onDeviceTap(DeviceType deviceType) {
    AppNavigator.displayDialog(_SelectDevicePopup(deviceType),
        barrierColor: Colors.grey.withOpacity(0.75));
  }


  Widget buildDashboardBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ColoredBox(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: DeviceControlPanelView(
              onPressed: (device) => onDeviceTap(device.type),
            ),
          ),
        ),
        const Flexible(flex: 3, child: RoomListView()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool atLeastOneHome =
        BlocProvider.of<HomeBloc>(context, listen: true).state.homes.isNotEmpty;

    return atLeastOneHome
        ? buildDashboardBody(context)
        : Center(child: Text(AppLocalizations.of(context)!.noHomes));
  }
}

class _SelectDevicePopup extends StatelessWidget {
  const _SelectDevicePopup(this.deviceType);

  final DeviceType deviceType;

  void onDeviceSelected(int index) {
    AppNavigator.pop(deviceType);
  }

  List<Device> getDevicesList(BuildContext context) {
    return BlocProvider.of<RoomBloc>(context, listen: false)
        .state
        .getDeviceList(deviceType);
  }

  Widget buildActionEntry(BuildContext context, Device device) {
    return GestureDetector(
      onTap: () => onDeviceSelected(device.index!),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${device.name} ${deviceType.name}}",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Device> devices = getDevicesList(context);

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
