import 'package:smarthome_algeria/src/features/room/room_feature.dart';
import 'package:smarthome_algeria/src/services/localDatabase/roomsTable/delegate.dart';
import 'package:smarthome_algeria/src/services/localDatabase/service.dart';
import 'package:smarthome_algeria/src/services/servicesProvider/service.dart';

class AddRoomMessage extends ServiceMessage {
  final _serviceId = AppServices.localDatabase.index;
  final _taskId = DatabaseActions.insertRoom.index;
  late InsertRoomData _data;

  AddRoomMessage(
      {required Room room, required int homeId, required VoidCallback callback})
      : super(
          voidCallback: callback,
          expectingVoidCallback: true,
        ) {
    _data = InsertRoomData(homeId, room.id, room.name);
  }

  @override
  ServiceMessageData getDataObject(int messageId) {
    return ServiceMessageData<InsertRoomData>(_data,
        messageId: messageId, serviceId: _serviceId, taskId: _taskId);
  }
}

class UpdateRoomMessage extends ServiceMessage {
  final _serviceId = AppServices.localDatabase.index;
  final _taskId = DatabaseActions.updateRoom.index;
  late UpdateRoomData _data;

  UpdateRoomMessage(
      {required Room room, required int homeId, required VoidCallback callback})
      : super(
          voidCallback: callback,
          expectingVoidCallback: true,
        ) {
    _data = UpdateRoomData(homeId, room.id, room.name);
  }

  @override
  ServiceMessageData getDataObject(int messageId) {
    return ServiceMessageData<UpdateRoomData>(_data,
        messageId: messageId, serviceId: _serviceId, taskId: _taskId);
  }
}

class DeleteRoomMessage extends ServiceMessage {
  final _serviceId = AppServices.localDatabase.index;
  final _taskId = DatabaseActions.deleteRoom.index;
  late DeleteRoomData _data;

  DeleteRoomMessage(
      {required Room room, required int homeId, required VoidCallback callback})
      : super(
          voidCallback: callback,
          expectingVoidCallback: true,
        ) {
    _data = DeleteRoomData(homeId, room.id);
  }

  @override
  ServiceMessageData getDataObject(int messageId) {
    return ServiceMessageData<DeleteRoomData>(_data,
        messageId: messageId, serviceId: _serviceId, taskId: _taskId);
  }
}

class LoadAllRoomsMessage extends ServiceMessage {
  final _serviceId = AppServices.localDatabase.index;
  final _taskId = DatabaseActions.selectRoom.index;

  late SelecRoomData _data;

  LoadAllRoomsMessage(
      {required int homeId, required TypedCallback<List<Room>> callback})
      : super(
          callback: callback,
          expectingCallback: true,
        ) {
    _data = SelecRoomData(homeId);
  }

  @override
  ServiceMessageData getDataObject(int messageId) {
    return ServiceMessageData<SelecRoomData>(_data,
        messageId: messageId, serviceId: _serviceId, taskId: _taskId);
  }
}
