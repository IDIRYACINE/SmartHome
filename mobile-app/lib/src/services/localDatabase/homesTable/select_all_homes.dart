import 'package:smarthome_algeria/src/services/servicesProvider/types.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:smarthome_algeria/src/services/localDatabase/types.dart' as app;

class SelectAllHomes extends TaskDelegate<void, void> {
  final Database _db;
  late ServiceMessageData<void> _messageData;

  SelectAllHomes(this._db);

  @override
  Future<ServiceResponse<void>> execute() async {
    ServiceResponse response;
    try {
      _selectHome();

      response = ServiceResponse(
        data: null,
        messageId: _messageData.messageId,
        status: OperationStatus.success,
      );
    } catch (e) {
      response = ServiceResponse(
        data: null,
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

  void _selectHome() {
    final stmt = _db.prepare('''
      SELECT * FROM homes
      ''');

    stmt.execute();
    stmt.dispose();
  }

  @override
  int get taskId => app.DatabaseActions.selectHome.index;
}
