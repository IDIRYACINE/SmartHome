import 'package:smarthome_algeria/src/services/servicesProvider/types.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:smarthome_algeria/src/services/localDatabase/types.dart' as app;

import 'delegate.dart';

class DeleteHome extends TaskDelegate<void, DeleteHomeData> {
  final Database _db;
  late ServiceMessageData<DeleteHomeData> _messageData;

  DeleteHome(this._db);

  @override
  Future<ServiceResponse<void>> execute() async{
   ServiceResponse response;
    try {
      _deleteHome();

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
  Future<void> setTaskData(ServiceMessageData<DeleteHomeData> message) async{
    _messageData = message;
  }
  
  void _deleteHome() {

    final stmt = _db.prepare(
      '''
      DELETE FROM homes
      WHERE ${HomeTableAttributes.homeId.name} = ?
      ''');

    stmt.execute([_messageData.data!.homeId]);
    stmt.dispose();
  }


  @override
  int get taskId => app.DatabaseActions.deleteHome.index;
}
