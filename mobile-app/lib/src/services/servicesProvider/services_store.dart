
import 'dart:isolate';

import 'package:smarthome_algeria/src/services/servicesProvider/types.dart';

import 'services_gateway.dart';

class ServicesProvider  {

  ServicesProvider._(String documentsPath){
    ReceivePort uiPort = ReceivePort();

    uiPort.listen((message) {
      if (message is SendPort) {
        _backgroundThreadPort = message;

        return;
      }

      _receiveMessage(message);
    });

    IsolateParameters params = IsolateParameters( uiPort.sendPort, documentsPath);

    Isolate.spawn<IsolateParameters>(_registerPort, params);
  }

  static ServicesProvider? _instance;

  static ServicesProvider get instance => _instance!;

  late SendPort _backgroundThreadPort;


  final List<ServiceMessage> _messagesQueue = [];

  static ServicesProvider getInstance(String? documentsPath) {
    _instance ??= ServicesProvider._(documentsPath!);
    return _instance!;
  }

  void _registerPort(IsolateParameters params) async {
    ReceivePort servicePort = ReceivePort();

    ServiceGateway eventsForwarder =
        ServiceForwarder(uiThreadPort: params.uiThreadPort,documentsPath: params.appDocumentsPath);

    params.uiThreadPort.send(servicePort.sendPort);

    servicePort.listen((message) {
      eventsForwarder.forwardMessage(message);
    });
  }

  void sendMessage(ServiceMessage message) {
    int messageId = _messagesQueue.length;
    ServiceMessageData jsonMessage = message.getDataObject(messageId);
    message.messageId = messageId;
    _backgroundThreadPort.send(jsonMessage);
    _messagesQueue.add( message);
  }

  void _receiveMessage(ServiceResponse response) {
    // using dyanamic type checking to avoid runtime errors ,
    // otherwise message generic type is casted to dynamic instead of T

    final message = _binarySearchServiceMessage(response.messageId);

    if(message == null) {
      return;
    }

    if (message.expectingCallback) {
      message.callback?.call(response.data);
    }

    if (message.expectingVoidCallback) {
      message.voidCallback?.call();
    }


    _messagesQueue.remove(message);
  }


  ServiceMessage? _binarySearchServiceMessage(int messageId) {
    int min = 0;
    int max = _messagesQueue.length - 1;



    while (min <= max) {
      int mid = (min + max) ~/ 2;
      int midVal = _messagesQueue[mid].messageId;

      if (midVal < messageId) {
        min = mid + 1;
      } else if (midVal > messageId) {
        max = mid - 1;
      } else {
        return _messagesQueue[mid];
      }
    }

    return null;
  }
}
