import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_algeria/src/features/home/state/home_bloc.dart';
import 'package:smarthome_algeria/src/features/room/room_feature.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RoomListView extends StatefulWidget {
  const RoomListView({super.key});

  @override
  State<RoomListView> createState() => _RoomListViewState();
}

class _RoomListViewState extends State<RoomListView> {
  late List<Room> rooms;

  Room getRoom(int roomIndex) {
    return rooms[roomIndex];
  }

  @override
  Widget build(BuildContext context) {
    rooms = BlocProvider.of<HomeBloc>(context, listen: true).state.getRooms();
    
    return rooms.isNotEmpty
        ? ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              return RoomPreviewWidget(
                room: getRoom(index),
              );
            },
          )
        : Center(
            child: Text(AppLocalizations.of(context)!.noRooms),
          );
  }
}
