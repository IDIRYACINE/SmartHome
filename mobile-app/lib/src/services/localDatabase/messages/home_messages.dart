import 'package:smarthome_algeria/src/features/home/home_feature.dart';
import 'package:smarthome_algeria/src/services/localDatabase/homesTable/types.dart';
import 'package:smarthome_algeria/src/services/localDatabase/types.dart';
import 'package:smarthome_algeria/src/services/servicesProvider/types.dart';

class AddHomeMessage extends ServiceMessage {
  final _serviceId = AppServices.localDatabase.index;
  final _taskId = DatabaseActions.insertHome.index;
  late InsertHomeData _data;

  AddHomeMessage({required Home home, required VoidCallback callback})
      : super(
          voidCallback: callback,
          expectingVoidCallback: true,
        ) {
    _data = InsertHomeData(home.id, home.name);
  }

  @override
  ServiceMessageData getDataObject(int messageId) {
    return ServiceMessageData<InsertHomeData>(_data,
        messageId: messageId, serviceId: _serviceId, taskId: _taskId);
  }
}

class UpdateHomeMessage extends ServiceMessage {
  final _serviceId = AppServices.localDatabase.index;
  final _taskId = DatabaseActions.updateHome.index;
  late UpdateHomeData _data;

  UpdateHomeMessage({required Home home, required VoidCallback callback})
      : super(
          voidCallback: callback,
          expectingVoidCallback: true,
        ) {
    _data = UpdateHomeData(home.id, home.name);
  }

  @override
  ServiceMessageData getDataObject(int messageId) {
    return ServiceMessageData<UpdateHomeData>(_data,
        messageId: messageId, serviceId: _serviceId, taskId: _taskId);
  }
}

class DeleteHomeMessage extends ServiceMessage {
  final _serviceId = AppServices.localDatabase.index;
  final _taskId = DatabaseActions.deleteHome.index;
  late DeleteHomeData _data;

  DeleteHomeMessage({required int homeId, required VoidCallback callback})
      : super(
          voidCallback: callback,
          expectingVoidCallback: true,
        ) {
    _data = DeleteHomeData(homeId);
  }

  @override
  ServiceMessageData getDataObject(int messageId) {
    return ServiceMessageData<DeleteHomeData>(_data,
        messageId: messageId, serviceId: _serviceId, taskId: _taskId);
  }
}

class LoadAllHomesMessage extends ServiceMessage {
  final _serviceId = AppServices.localDatabase.index;
  final _taskId = DatabaseActions.selectHome.index;

  LoadAllHomesMessage({required TypedCallback<List<Home>> callback})
      : super(
          callback: callback,
          expectingCallback: true,
        );

  @override
  ServiceMessageData getDataObject(int messageId) {
    return ServiceMessageData<void>(null,
        messageId: messageId, serviceId: _serviceId, taskId: _taskId);
  }
}
