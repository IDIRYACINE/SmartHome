
enum DevicesTableAttributes{
  deviceId,
  roomId,
  homeId,
  deviceName,
  deviceType,
  deviceSubtype,
  deviceConsumption,

}

extension Attributes on DevicesTableAttributes{
  String get name{
    switch(this){
      case DevicesTableAttributes.deviceId:
        return 'device_id';
      case DevicesTableAttributes.roomId:
        return 'room_id';
      case DevicesTableAttributes.homeId:
        return 'home_id';
      case DevicesTableAttributes.deviceName:
        return 'device_name';
      case DevicesTableAttributes.deviceType:
        return 'device_type';
      case DevicesTableAttributes.deviceSubtype:
        return 'device_subtype';
      case DevicesTableAttributes.deviceConsumption:
        return 'device_consumption';
    }
  }

  String get type{
    switch(this){
      case DevicesTableAttributes.deviceId:
        return 'INTEGER PRIMARY KEY';
      case DevicesTableAttributes.roomId:
        return 'INTEGER NOT NULL';
      case DevicesTableAttributes.homeId:
        return 'INTEGER NOT NULL';
      case DevicesTableAttributes.deviceName:
        return 'TEXT NOT NULL';
      case DevicesTableAttributes.deviceType:
        return 'INTEGER NOT NULL';
      case DevicesTableAttributes.deviceSubtype:
        return 'INTEGER NOT NULL';
      case DevicesTableAttributes.deviceConsumption:
        return 'INTEGER NOT NULL';
    }
  }
}

class UpdateDeviceData{
  final int deviceId;
  final int roomId;
  final int homeId;
  final String deviceName;
  final int deviceType;
  final int deviceSubtype;
  final int deviceConsumption;

  UpdateDeviceData( this.homeId,this.roomId,this.deviceId, this.deviceName,this.deviceType,this.deviceSubtype,this.deviceConsumption);
}

class DeleteDeviceData{
  final int deviceId;
  final int roomId;
  final int homeId;

  DeleteDeviceData( this.homeId,this.roomId,this.deviceId);
}

class InsertDeviceData{
  final int deviceId;
  final int roomId;
  final int homeId;
  final String deviceName;
  final int deviceType;
  final int deviceSubtype;
  final int deviceConsumption;

  InsertDeviceData( this.homeId,this.roomId,this.deviceId, this.deviceName,this.deviceType,this.deviceSubtype,this.deviceConsumption);
}

class SelectDeviceData{
  final int homeId;
  final int roomId;
  

  SelectDeviceData( this.homeId,this.roomId);
}
