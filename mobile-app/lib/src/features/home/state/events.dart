import '../domain/home.dart';

class HomeEvents {}

class AddHome extends HomeEvents {
  final String homeName;

  AddHome(
    this.homeName,
  );
}

class UpdateHome extends HomeEvents {
  final Home home;
  final int index;

  UpdateHome(this.home, this.index);
}

class RemoveHome extends HomeEvents {
  final int index;
  final int homeId;

  RemoveHome(this.index, this.homeId);
}

class SelectHome extends HomeEvents {
  final Home home;

  SelectHome(this.home);
}

class LoadAllHomes extends HomeEvents {
  final List<Home> homes;

  LoadAllHomes(this.homes);
}