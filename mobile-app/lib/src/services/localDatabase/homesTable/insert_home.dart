import 'package:smarthome_algeria/src/services/localDatabase/homesTable/delegate.dart';
import 'package:smarthome_algeria/src/services/servicesProvider/types.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:smarthome_algeria/src/services/localDatabase/types.dart' as app;

class InsertHome extends TaskDelegate<void, InsertHomeData> {
  final Database _db;
  late ServiceMessageData<InsertHomeData> _messageData;

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
  Future<void> setTaskData(ServiceMessageData<InsertHomeData> message) async {
    _messageData = message;
  }

  Future<void> _insertHome() async {
    final homeData = _messageData.data as InsertHomeData;

    final stmt = _db.prepare(
      '''
      INSERT INTO homes (
        ${HomeTableAttributes.homeId.name},
        ${HomeTableAttributes.homeName.name}
        )
      VALUES (?, ?)
      ''');

    stmt.execute([homeData.homeId, homeData.homeName]);
    stmt.dispose();
  }

  @override
  int get taskId => app.DatabaseActions.insertHome.index;
}
