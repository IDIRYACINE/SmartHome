import 'package:smarthome_algeria/src/features/room/domain/room.dart';
import '../domain/home.dart';

class HomeEvents {}

class AddHome extends HomeEvents {
  final String homeName;

  AddHome(
    this.homeName,
  );
}

class UpdateHome extends HomeEvents {
  final Home home;
  final int index;

  UpdateHome(this.home, this.index);
}

class RemoveHome extends HomeEvents {
  final int index;
  final int homeId;

  RemoveHome(this.index, this.homeId);
}

class SelectHome extends HomeEvents {
  final Home home;

  SelectHome(this.home);
}

class AddRoom extends HomeEvents {
  final String roomName;

  AddRoom(this.roomName,);
}

class UpdateRoom extends HomeEvents {
  final Room room;
  final int index;

  UpdateRoom(this.room,this.index);
}

class RemoveRoom extends HomeEvents {
  final Room room;

  RemoveRoom(this.room, );
}
