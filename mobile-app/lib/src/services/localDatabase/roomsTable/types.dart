
enum RoomsTableAttributes{
  roomId,
  homeId,
  roomName
}

extension Attributes on RoomsTableAttributes{
  String get name{
    switch(this){
      case RoomsTableAttributes.roomId:
        return 'room_id';
      case RoomsTableAttributes.homeId:
        return 'hoome_id';
      case RoomsTableAttributes.roomName:
        return 'room_name';
    }
  }

  String get type{
    switch(this){
      case RoomsTableAttributes.roomId:
        return 'INTEGER PRIMARY KEY';
      case RoomsTableAttributes.homeId:
        return 'INTEGER NOT NULL';
      case RoomsTableAttributes.roomName:
        return 'TEXT NOT NULL';
    }
  }
}

class UpdateRoomData{
  final int roomId;
  final int homeId;
  final String roomName;

  UpdateRoomData( this.homeId,this.roomId, this.roomName);
}

class DeleteRoomData{
  final int roomId;
  final int homeId;

  DeleteRoomData( this.homeId,this.roomId);
}

class InsertRoomData{
  final int roomId;
  final int homeId;
  final String roomName;

  InsertRoomData( this.homeId,this.roomId, this.roomName);
}

class SelecRoomData{
  final int homeId;

  SelecRoomData( this.homeId);
}

