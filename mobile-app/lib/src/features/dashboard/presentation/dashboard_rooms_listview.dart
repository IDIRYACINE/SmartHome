import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_algeria/src/features/room/room_feature.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RoomListView extends StatefulWidget {
  const RoomListView({super.key});

  @override
  State<RoomListView> createState() => _RoomListViewState();
}

class _RoomListViewState extends State<RoomListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomBloc, RoomState>(
        buildWhen: (previous, current) =>
            previous.rooms.length != current.rooms.length,
        builder: (context, state) {
          return state.rooms.isNotEmpty
              ? ListView.builder(
                  itemCount: state.rooms.length,
                  itemBuilder: (context, index) {
                    return RoomPreviewWidget(
                      roomIndex: index,
                    );
                  },
                )
              : Center(
                  child: Text(AppLocalizations.of(context)!.noRooms),
                );
        });
  }
}
