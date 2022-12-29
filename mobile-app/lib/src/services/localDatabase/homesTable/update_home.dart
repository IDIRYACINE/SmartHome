

import 'package:smarthome_algeria/src/features/home/domain/home.dart';
import 'package:smarthome_algeria/src/services/localDatabase/types.dart' as app;
import 'package:smarthome_algeria/src/services/servicesProvider/types.dart' ;
import 'package:sqlite3/sqlite3.dart';

import 'delegate.dart';


class UpdateHome extends TaskDelegate<void, Home> {
  final Database _db;
  late ServiceMessageData _messageData;

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
  Future<void> setTaskData(ServiceMessageData<Home> message) async{
    _messageData = message;
  }
  
  void _updateHome() {
    final home = _messageData.data as Home;

    final stmt = _db.prepare(
      '''
      UPDATE homes
      SET ${HomeTableAttributes.homeName.name} = ?
      WHERE ${HomeTableAttributes.homeId.name} = ?
      ''');

      
    stmt.execute([home.id]);
    stmt.dispose();
  }

    @override
  int get taskId => app.DatabaseActions.updateHome.index;
}