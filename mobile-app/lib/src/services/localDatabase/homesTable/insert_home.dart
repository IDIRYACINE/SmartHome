import 'package:smarthome_algeria/src/features/home/domain/home.dart';
import 'package:smarthome_algeria/src/services/localDatabase/homesTable/delegate.dart';
import 'package:smarthome_algeria/src/services/servicesProvider/types.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:smarthome_algeria/src/services/localDatabase/types.dart' as app;

class InsertHome extends TaskDelegate<void, Home> {
  final Database _db;
  late ServiceMessageData _messageData;

  InsertHome(this._db);

  @override
  Future<ServiceResponse<void>> execute() async {
    ServiceResponse response;
    try {
      _insertHome();

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
  Future<void> setTaskData(ServiceMessageData message) async {
    _messageData = message;
  }

  Future<void> _insertHome() async {
    final home = _messageData.data as Home;

    final stmt = _db.prepare(
      '''
      INSERT INTO homes (
        ${HomeTableAttributes.homeId},
        ${HomeTableAttributes.homeName},
        )
      VALUES (?, ?)
      ''');

    stmt.execute([home.id, home.name]);
    stmt.dispose();
  }

  @override
  int get taskId => app.DatabaseActions.insertHome.index;
}
