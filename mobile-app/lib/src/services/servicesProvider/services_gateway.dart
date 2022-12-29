

import 'dart:isolate';

import 'types.dart';

class ServiceForwarder implements ServiceGateway {
  ServiceForwarder({required this.uiThreadPort});

  final SendPort uiThreadPort;

  @override
  Future<void> forwardMessage(ServiceMessageData message) async{
    uiThreadPort.send(message);
  }
  
  @override
  Future<void> registerService(Service service) {
    //TODO implement
    throw UnimplementedError();
  }
  
}