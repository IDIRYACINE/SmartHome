

import 'devices.dart';

class DeviceEditorData {
  final Device? device;
  final bool isEditMode;
  final int? index;

  DeviceEditorData({this.index,this.device, this.isEditMode = false});
}