import 'package:smarthome_algeria/src/features/home/domain/home.dart';
import 'package:sqlite3/common.dart';

import '../homesTable/delegate.dart';

List<Home> resultSetToHomeList(ResultSet resultSet) {
  List<Home> homes = [];
  Home home;
  for (Row row in resultSet) {
    try {
      home = Home(
          index: homes.length,
          name: row[HomeTableAttributes.homeName.name],
          id: row[HomeTableAttributes.homeId.name]);
      homes.add(home);
    } on Exception {
      // nothing to do
    }
  }
  return homes;
}
