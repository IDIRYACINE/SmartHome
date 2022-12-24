import 'package:equatable/equatable.dart';
import 'package:smarthome_algeria/src/features/room/domain/room.dart';

import '../domain/home.dart';

class HomeState extends Equatable {
  final List<Home> homes;
  final Home? currentHome;

  const HomeState({required this.homes, this.currentHome});

  static HomeState initialState({List<Home>? homes, Home? currentHome}) {
    homes ??= [];

    if (homes.isNotEmpty) {
      currentHome ??= homes.first;
    }

    return HomeState(homes: homes, currentHome: currentHome);
  }
  
  @override
  List<Object?> get props => [homes,currentHome];

  HomeState copyWith({List<Home>? homes, Home? currentHome}) {
    return HomeState(
      homes: homes ?? this.homes,
      currentHome: currentHome ?? this.currentHome,
    );
  }

  List<Room> getRooms() {
    if(currentHome == null){
      return [];
    }
    return currentHome!.rooms ;
  }

}
