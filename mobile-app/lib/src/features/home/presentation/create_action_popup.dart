import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/features/devices/data/routes_data.dart';
import 'package:smarthome_algeria/src/features/home/state/home_bloc.dart';

class CreateActionPopup extends StatelessWidget {
  const CreateActionPopup({Key? key}) : super(key: key);

  void onNewHomePressed() {
    AppNavigator.pop();
    AppNavigator.pushNamed(homeEditorRoute);
  }

  void onNewDevicePressed(BuildContext context) {
    int homeId = BlocProvider.of<HomeBloc>(context).state.currentHomeIndex;
    AppNavigator.pop();
    AppNavigator.pushNamed(deviceEditorRoute, arguments: DeviceEditorData(homeId: homeId));
  }

  void onNewRoomPressed() {
    AppNavigator.pop();
    AppNavigator.pushNamed(roomEditorRoute);
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;

    return AlertDialog(
        content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MaterialButton(
          minWidth: double.infinity,
          onPressed: onNewHomePressed,
          child: Text(
            _PopupMenuItem.newHome.label(context),
            style: textStyle,
          ),
        ),
        MaterialButton(
          minWidth: double.infinity,
          onPressed: () => onNewDevicePressed(context),
          child: Text(
            _PopupMenuItem.newDevice.label(context),
            style: textStyle,
          ),
        ),
        MaterialButton(
          minWidth: double.infinity,
          onPressed: onNewRoomPressed,
          child: Text(
            _PopupMenuItem.newRoom.label(context),
            style: textStyle,
          ),
        ),
      ],
    ));
  }
}

enum _PopupMenuItem { newHome, newDevice, newRoom }

extension _PopupMenuItemExtension on _PopupMenuItem {
  String label(BuildContext context) {
    switch (this) {
      case _PopupMenuItem.newHome:
        return AppLocalizations.of(context)!.newHome;
      case _PopupMenuItem.newDevice:
        return AppLocalizations.of(context)!.newDevice;
      case _PopupMenuItem.newRoom:
        return AppLocalizations.of(context)!.newRoom;
    }
  }
}
