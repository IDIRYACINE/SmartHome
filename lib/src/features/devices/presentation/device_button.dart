
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_algeria/src/features/devices/data/devices.dart';
import 'package:smarthome_algeria/src/features/devices/presentation/device_label.dart';
import 'package:smarthome_algeria/src/features/home/state/home_bloc.dart';
import 'package:smarthome_algeria/src/features/room/room_feature.dart';

import '../data/type_aliases.dart';

class DeviceButton<T> extends StatelessWidget{
  const DeviceButton({super.key, required this.onPressed, required this.device});

  final DeviceClickCallback onPressed;
  final Device device;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(device),
      child: RoundDeviceLabel(device: device,)
    );
  }
}

class DeviceRoomSelector extends StatefulWidget{
  const DeviceRoomSelector({super.key, required this.onRoomSelected});

  final RoomClickCallback onRoomSelected;

  @override
  State<StatefulWidget> createState() => _DeviceRoomSelectorState();
}

class _DeviceRoomSelectorState extends State<DeviceRoomSelector>{

  List<Room>? rooms;
  Room? selectedRoom;

  void onChanged(Room? value){
    setState(() {
      selectedRoom = value;
    });
  }

  List<DropdownMenuItem<Room>> buildItems(){
    List<DropdownMenuItem<Room>> items = [];

    rooms?.forEach((room) {
      items.add(DropdownMenuItem<Room>(value: room, child: Text(room.name)));
    });

    return items;
  }


  @override
  Widget build(BuildContext context) {
    rooms ??= BlocProvider.of<HomeBloc>(context).state.getRooms();

    return DropdownButtonFormField<Room>(
      value: selectedRoom,
      items: buildItems(), onChanged: onChanged);
  }
}