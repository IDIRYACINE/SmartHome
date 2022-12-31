import 'package:smarthome_algeria/src/features/home/domain/home.dart';
import 'package:smarthome_algeria/src/services/localDatabase/repository/home_repository.dart';
import 'package:smarthome_algeria/src/services/servicesProvider/types.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:smarthome_algeria/src/services/localDatabase/types.dart' as app;

class SelectAllHomes extends TaskDelegate<List<Home>, void> {
  final Database _db;
  late ServiceMessageData<void> _messageData;

  SelectAllHomes(this._db);

  @override
  Future<ServiceResponse<List<Home>>> execute() async {
    ServiceResponse<List<Home>> response;
    List<Home> homes;
    try {
      homes = _loadAllHomes();

      response = ServiceResponse<List<Home>>(
        data: homes,
        messageId: _messageData.messageId,
        status: OperationStatus.success,
      );
    } catch (e) {
      response = ServiceResponse<List<Home>>(
        data: [],
        messageId: _messageData.messageId,
        status: OperationStatus.error,
      );
    }

    return response;
  }

  @override
  Future<void> setTaskData(ServiceMessageData<void> message) async {
    _messageData = message;
  }

  List<Home> _loadAllHomes() {
    final stmt = _db.prepare('''
      SELECT * FROM homes
      ''');

    ResultSet results = stmt.select();

    stmt.dispose();

    return resultSetToHomeList(results);
  }

  @override
  int get taskId => app.DatabaseActions.selectHome.index;
}
