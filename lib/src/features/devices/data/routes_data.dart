

import 'devices.dart';

class DeviceEditorData {
  final Device? device;
  final bool isEditMode;
  final int? index;
  final int? roomIndex;

  DeviceEditorData( {this.roomIndex,this.index,this.device, this.isEditMode = false});
}