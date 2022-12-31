import 'dart:isolate';

import 'package:smarthome_algeria/src/services/localDatabase/service.dart';
import 'package:smarthome_algeria/src/services/remoteServer/service.dart';

import 'types.dart';

class ServiceForwarder implements ServiceGateway {
  ServiceForwarder({required this.uiThreadPort}) {
    _registerServices();
  }

  final SendPort uiThreadPort;
  final List<Service> _services = [];

  @override
  Future<void> forwardMessage(ServiceMessageData message) async {
    Service? delegate;

    for (Service service in _services) {
      if (service.serviceId == message.serviceId) {
        delegate = service;
        break;
      }
    }

    delegate
        ?.handleMessage(message)
        .then((response) => uiThreadPort.send(response));
  }

  @override
  Future<void> registerService(Service service) async {
    _services.add(service);
  }

  void _registerServices() {
    _services.add(SqliteDatabase());
    _services.add(RemoteServer());
  }
}
