import 'package:equatable/equatable.dart';
import 'package:smarthome_algeria/src/features/devices/data/device_archetype.dart';
import 'package:smarthome_algeria/src/features/room/domain/room.dart';

import '../domain/home.dart';

class HomeState extends Equatable {
  final List<Home> homes;
  final int currentHomeIndex ;

  const HomeState({required this.homes, this.currentHomeIndex = 0});

  static HomeState initialState({List<Home>? homes, Home? currentHome}) {
    homes ??= [];


    return HomeState(homes: homes, currentHomeIndex: 0);
  }
  
  @override
  List<Object?> get props => [homes,currentHomeIndex];

  HomeState copyWith({List<Home>? homes, int? currentHomeIndex}) {
    return HomeState(
      homes: homes ?? this.homes,
      currentHomeIndex: currentHomeIndex ?? this.currentHomeIndex,
    );
  }

  List<Room> get rooms {
    return currentHome?.rooms ?? [] ;
  }

  Home? get currentHome {
    if(currentHomeIndex >= homes.length){
      return null;
    }
   return homes[currentHomeIndex];
  }

  getArchetypeDeviceList(DeviceArchetype deviceArchetype) {} 

}
