import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/features/devices/data/device_archetype.dart';
import 'package:smarthome_algeria/src/features/devices/data/devices.dart';
import 'package:smarthome_algeria/src/features/devices/presentation/device_label.dart';
import 'package:smarthome_algeria/src/features/home/state/home_bloc.dart';
import 'package:smarthome_algeria/src/features/room/room_feature.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../data/type_aliases.dart';

class DeviceButton<T> extends StatelessWidget {
  const DeviceButton(
      {super.key, required this.onPressed, required this.device});

  final DeviceClickCallback onPressed;
  final Device device;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onPressed(device),
        child: RoundDeviceLabel(
          device: device,
        ));
  }
}

class DeviceSummaryCard extends StatelessWidget {
  const DeviceSummaryCard({super.key, required this.deviceArchetype});

  final DeviceArchetype deviceArchetype;

  void navigateToDeviceArchetype() {
    AppNavigator.pushNamed(deviceArchetypeRoute, arguments: deviceArchetype);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: InkWell(
        onTap: () => navigateToDeviceArchetype(),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(deviceArchetype.icon),
              Text(deviceArchetype.name),
              BlocSelector<RoomBloc, RoomState, int>(
                  selector: (state) =>
                      state.getDeviceArchetypeCount(deviceArchetype.type),
                  builder: (context, deviceCount) {
                    return Text(
                        "$deviceCount ${AppLocalizations.of(context)!.devices}");
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class DeviceTypeCard extends StatefulWidget {
  const DeviceTypeCard(
      {super.key,
      required this.deviceArchetype,
      required this.onPressed,
      this.isSelected = false,
      required this.index,
      required this.registerTurnOffCallback});

  final DeviceArchetype deviceArchetype;

  final DeviceTypePressed onPressed;

  final bool isSelected;

  final DeviceTypeOffCallback registerTurnOffCallback;

  final int index;

  @override
  State<DeviceTypeCard> createState() => _DeviceTypeCardState();
}

class _DeviceTypeCardState extends State<DeviceTypeCard> {
  bool? isSelected;
  ThemeData? theme;

  void turnOff() {
    setState(() {
      isSelected = false;
    });
  }

  void turnOn() {
    setState(() {
      isSelected = true;
      widget.onPressed(widget.index, widget.deviceArchetype);
      widget.registerTurnOffCallback(turnOff);
    });
  }

  @override
  Widget build(BuildContext context) {
    isSelected ??= widget.isSelected;
    theme ??= Theme.of(context);

    return SizedBox(
      width: 200,
      child: InkWell(
        onTap: turnOn,
        child: Card(
          color: isSelected! ? theme!.colorScheme.primaryContainer : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(widget.deviceArchetype.icon),
              Text(widget.deviceArchetype.name),
              BlocSelector<RoomBloc, RoomState, int>(
                  selector: (state) => state
                      .getDeviceArchetypeCount(widget.deviceArchetype.type),
                  builder: (context, deviceCount) {
                    return Text(
                        "$deviceCount ${AppLocalizations.of(context)!.devices}");
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class DeviceRoomSelector extends StatefulWidget {
  const DeviceRoomSelector({super.key, required this.onRoomSelected});

  final RoomClickCallback onRoomSelected;

  @override
  State<StatefulWidget> createState() => _DeviceRoomSelectorState();
}

class _DeviceRoomSelectorState extends State<DeviceRoomSelector> {
  List<Room>? rooms;
  Room? selectedRoom;

  void onChanged(Room? value) {
    setState(() {
      selectedRoom = value;
    });
  }

  List<DropdownMenuItem<Room>> buildItems() {
    List<DropdownMenuItem<Room>> items = [];

    rooms?.forEach((room) {
      items.add(DropdownMenuItem<Room>(value: room, child: Text(room.name)));
    });

    return items;
  }

  @override
  Widget build(BuildContext context) {
    rooms ??= BlocProvider.of<HomeBloc>(context).state.rooms;

    return DropdownButtonFormField<Room>(
        decoration: InputDecoration(
          labelText:AppLocalizations.of(context)!.home,
        ),
        value: selectedRoom,
        items: buildItems(),
        onChanged: onChanged);
  }
}
