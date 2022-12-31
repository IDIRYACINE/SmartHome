
import 'package:smarthome_algeria/src/services/remoteServer/apis/post_device_state.dart';
import 'package:smarthome_algeria/src/services/remoteServer/utility/mqtt_wrapper.dart';
import 'package:smarthome_algeria/src/services/servicesProvider/service.dart';

class RemoteServer extends Service {
  late List<TaskDelegate> _actions;

  late MQTTClientWrapper _client;

  RemoteServer(
      {String serverUrl =
          '0cd5c4fc8a9d45468efdcc59f176a76d.s2.eu.hivemq.cloud:8883',
      String username = 'idiryacine',
      String password = 'Idiryacine34'}) {

    _client = MQTTClientWrapper();
    _client.prepareMqttClient();
  

    _registerActions();
  }

  @override
  Future<ServiceResponse> handleMessage(ServiceMessageData message) async {
    ServiceResponse response;
    try {
      final action = _actions[message.taskId];
      await action.setTaskData(message);
      response = await action.execute();
    } catch (e) {
      response = ServiceResponse(
        data: null,
        messageId: message.messageId,
        status: OperationStatus.error,
      );
    }
    return response;
  }


  @override
  int get serviceId => AppServices.remoteServer.index;

  void _registerActions() {
    _actions = [
      PostDeviceState(_client),
    ];
  }
}
