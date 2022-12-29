

import 'devices.dart';

class DeviceEditorData {
  final Device? device;
  final bool isEditMode;
  final int? index;
  final int? roomIndex;
  final int? homeId;

  DeviceEditorData( {this.roomIndex,this.homeId, this.index,this.device, this.isEditMode = false});
}