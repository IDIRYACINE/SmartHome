import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/core/state_manager/bloc.dart';
import '../domain/room.dart';
import '../domain/type_aliases.dart';

class ScaffoldRoomsSelectorView extends StatefulWidget {
  const ScaffoldRoomsSelectorView({Key? key}) : super(key: key);

  @override
  State<ScaffoldRoomsSelectorView> createState() => _ScaffoldRoomsSelectorViewState();
}

class _ScaffoldRoomsSelectorViewState extends State<ScaffoldRoomsSelectorView> {
  Room? selectedRoom;
  List<Room>? rooms;

  void onConfirm(Room? room) {
    AppNavigator.pop(room);
  }

  void setSelectedRoom(Room? room) {
    setState(() {
      selectedRoom = room;
    });
  }

  Widget buildRoomItem(int index, Room room) {
    return _RoomItemWidget(
      index: index,
      room: room,
      setSelectedRoom: setSelectedRoom,
      isSelected: selectedRoom == room,
    );
  }

  @override
  Widget build(BuildContext context) {
    rooms ??= BlocProvider.of<AppBloc>(context).state.rooms;

    return Scaffold(
      appBar: _AppBar(
        onConfirm: () => onConfirm(selectedRoom),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => buildRoomItem(index, rooms![index]),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: 5,
        ),
        itemCount: rooms!.length,
      ),
    );
  }
}

class _RoomItemWidget extends StatefulWidget {
  const _RoomItemWidget(
      {required this.room,
      required this.setSelectedRoom,
      this.isSelected = false,
      required this.index});

  final Room room;
  final int index;

  final RoomCallback setSelectedRoom;
  final bool isSelected;

  @override
  State<_RoomItemWidget> createState() => _RoomItemWidgetState();
}

class _RoomItemWidgetState extends State<_RoomItemWidget> {
  bool? isSelected;
  ThemeData? theme;

  void onTap() {
    widget.setSelectedRoom(isSelected! ? widget.room : null);
  }

  @override
  Widget build(BuildContext context) {
    isSelected ??= widget.isSelected;
    theme ??= Theme.of(context);

    Color color =
        isSelected! ? theme!.selectedRowColor : theme!.unselectedWidgetColor;

    return MaterialButton(
      color: color,
      onPressed: onTap,
      child: Text(widget.room.name),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({required this.onConfirm});

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.cancel_sharp),
        onPressed: () => AppNavigator.pop(),
      ),
      title: Text(AppLocalizations.of(context)!.rooms),
      actions: [
        IconButton(
          icon: const Icon(Icons.check),
          onPressed: onConfirm,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}



class PopupRoomsSelectorView extends StatefulWidget {
  const PopupRoomsSelectorView({Key? key}) : super(key: key);

  @override
  State<PopupRoomsSelectorView> createState() => _PopupRoomsSelectorViewState();
}

class _PopupRoomsSelectorViewState extends State<PopupRoomsSelectorView> {
  Room? selectedRoom;
  List<Room>? rooms;

  void onConfirm(Room? room) {
    AppNavigator.pop(room);
  }

  void setSelectedRoom(Room? room) {
    setState(() {
      selectedRoom = room;
    });
  }

  Widget buildRoomItem(int index, Room room) {
    return _RoomItemWidget(
      index: index,
      room: room,
      setSelectedRoom: setSelectedRoom,
      isSelected: selectedRoom == room,
    );
  }

  @override
  Widget build(BuildContext context) {
    rooms ??= BlocProvider.of<AppBloc>(context).state.rooms;

    return AlertDialog(
      content: ListView.separated(
        itemBuilder: (context, index) => buildRoomItem(index, rooms![index]),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: 5,
        ),
        itemCount: rooms!.length,
      ),
    );
  }
}
