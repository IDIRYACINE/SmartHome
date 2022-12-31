

import 'package:smarthome_algeria/src/services/localDatabase/types.dart' as app;
import 'package:smarthome_algeria/src/services/servicesProvider/types.dart' ;
import 'package:sqlite3/sqlite3.dart';

import 'delegate.dart';


class UpdateHome extends TaskDelegate<void, UpdateHomeData> {
  final Database _db;
  late ServiceMessageData<UpdateHomeData> _messageData;

  UpdateHome(this._db);

  @override
  Future<ServiceResponse<void>> execute() async{
   ServiceResponse response;
    try {
      _updateHome();

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
  Future<void> setTaskData(ServiceMessageData<UpdateHomeData> message) async{
    _messageData = message;
  }
  
  void _updateHome() {

    final stmt = _db.prepare(
      '''
      UPDATE homes
      SET ${HomeTableAttributes.homeName.name} = ?
      WHERE ${HomeTableAttributes.homeId.name} = ?
      ''');

      
    stmt.execute([_messageData.data!.homeId, _messageData.data!.homeName]);
    stmt.dispose();
  }

    @override
  int get taskId => app.DatabaseActions.updateHome.index;
}