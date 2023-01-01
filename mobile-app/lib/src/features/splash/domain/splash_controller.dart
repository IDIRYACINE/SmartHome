import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/features/home/home_feature.dart';
import 'package:smarthome_algeria/src/features/room/room_feature.dart';
import 'package:smarthome_algeria/src/services/localDatabase/service.dart';
import 'package:smarthome_algeria/src/services/servicesProvider/service.dart';

class SplashController {
  Future<void> loadHomesData(BuildContext context) async {
    ServiceMessage loadHomes =
        DatabaseMessageBuilder.selectAllHomesMessage((homes) {
      _loadRoomsData(context);
      BlocProvider.of<HomeBloc>(context).add(LoadAllHomes(homes));
    });

    ServicesProvider.instance.sendMessage(loadHomes);
  }

  Future<void> _loadRoomsData(BuildContext context) async {
    ServiceMessage loadRooms =
        DatabaseMessageBuilder.loadAllRoomsMessage((rooms) {
      List<RoomGroup> roomGroups = roomListToHomeGroupList(rooms);
      BlocProvider.of<RoomBloc>(context).add(LoadRoomGroups(roomGroups));

      Navigator.of(context).pushReplacementNamed(dashboardRoute);
    });

    ServicesProvider.instance.sendMessage(loadRooms);
  }

  List<RoomGroup> roomListToHomeGroupList(List<Room> rooms) {
    Map<int, RoomGroup> roomGroups = {};

    for (Room room in rooms) {
      if (roomGroups.containsKey(room.homeId)) {
        roomGroups[room.homeId]!.rooms.add(room);
      } else {
        roomGroups[room.homeId] = RoomGroup(homeId: room.homeId, rooms: [room]);
      }
    }

    return roomGroups.values.toList();
  }
}
