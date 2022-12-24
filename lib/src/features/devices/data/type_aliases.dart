import 'package:smarthome_algeria/src/features/room/room_feature.dart';

import 'devices.dart';

typedef DeviceClickCallback = void Function(Device data);
typedef DeviceTap = void Function(Device device);
typedef DeviceLongPress = void Function(Device device,int index);
typedef RoomClickCallback = void Function(Room data);

typedef OnConsumptionSelected = void Function(int? consumption);
typedef OnConsumptionChanged = void Function(String consumption);