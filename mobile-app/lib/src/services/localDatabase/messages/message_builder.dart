import 'package:smarthome_algeria/src/features/devices/devices_feature.dart';
import 'package:smarthome_algeria/src/features/home/home_feature.dart';
import 'package:smarthome_algeria/src/features/room/room_feature.dart';
import 'package:smarthome_algeria/src/services/localDatabase/messages/devices_messages.dart';
import 'package:smarthome_algeria/src/services/localDatabase/messages/home_messages.dart';
import 'package:smarthome_algeria/src/services/localDatabase/messages/room_messages.dart';
import 'package:smarthome_algeria/src/services/servicesProvider/types.dart';

abstract class DatabaseMessageBuilder {
  static AddHomeMessage addHomeMessage(Home home, VoidCallback callback) {
    return AddHomeMessage(home: home, callback: callback);
  }

  static UpdateHomeMessage updateHomeMessage(Home home, VoidCallback callback) {
    return UpdateHomeMessage(home: home, callback: callback);
  }

  static DeleteHomeMessage deleteHomeMessage(int homeId, VoidCallback callback) {
    return DeleteHomeMessage(homeId: homeId, callback: callback);
  }

  static LoadAllHomesMessage selectAllHomesMessage(
      TypedCallback<List<Home>> callback) {
    return LoadAllHomesMessage(callback: callback);
  }

  static AddRoomMessage addRoomMessage(
      Room room, int homeId, VoidCallback callback) {
    return AddRoomMessage(room: room, callback: callback, homeId: homeId);
  }

  static UpdateRoomMessage updateRoomMessage(
      Room room, int homeId, VoidCallback callback) {
    return UpdateRoomMessage(room: room, callback: callback, homeId: homeId);
  }

  static DeleteRoomMessage deleteRoomMessage(
      Room room, int homeId, VoidCallback callback) {
    return DeleteRoomMessage(room: room, callback: callback, homeId: homeId);
  }

  static LoadAllRoomsMessage loadAllRooms(
      int homeId, TypedCallback<List<Room>> callback) {
    return LoadAllRoomsMessage(
      homeId: homeId,
      callback: callback,
    );
  }

  static AddDeviceMessage addDeviceMessage(
      Device device, VoidCallback callback) {
    return AddDeviceMessage(
      device: device,
      callback: callback,
    );
  }

  static UpdateDeviceMessage updateDeviceMessage(
      Device device, VoidCallback callback) {
    return UpdateDeviceMessage(
      device: device,
      callback: callback,
    );
  }

  static DeleteDeviceMessage deleteDeviceMessage(
      Device device, VoidCallback callback) {
    return DeleteDeviceMessage(
      device: device,
      callback: callback,
    );
  }

  static LoadAllDevicesMessage loadAllDevicesMessage(
      int homeId, int roomId, TypedCallback<List<Device>> callback) {
    return LoadAllDevicesMessage(
      callback: callback,
      homeId: homeId,
      roomId: roomId,
    );
  }
}
