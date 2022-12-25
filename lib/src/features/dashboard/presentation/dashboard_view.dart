import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_algeria/src/core/state_manager/bloc.dart';
import 'package:smarthome_algeria/src/features/dashboard/presentation/dashboard_rooms_listview.dart';
import 'package:smarthome_algeria/src/features/devices/devices_feature.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});


  Widget buildDashboardBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ColoredBox(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: DeviceControlPanelView(
              onPressed: (device) => {},
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
        BlocProvider.of<AppBloc>(context, listen: true).state.homes.isNotEmpty;

    return atLeastOneHome
        ? buildDashboardBody(context)
        : Center(child: Text(AppLocalizations.of(context)!.noHomes));
  }
}
