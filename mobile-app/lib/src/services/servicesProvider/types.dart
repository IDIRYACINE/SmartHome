import 'dart:isolate';

typedef VoidCallback = void Function();
typedef TypedCallback<T> = void Function(T);

abstract class ServiceMessage {
  int messageId;

  final bool expectingCallback;
  final bool expectingVoidCallback;

  final VoidCallback? voidCallback;
  final dynamic callback;

  final TypedCallback? failedCallback;

  ServiceMessage({
    this.messageId = -1,
    this.voidCallback,
    this.callback,
    this.failedCallback,
    this.expectingCallback = false,
    this.expectingVoidCallback = false,
  })  : assert(
            (expectingCallback && callback != null) ||
                (!expectingCallback && callback == null),
            "expectingCallback but callback is null"),
        assert(
            (expectingVoidCallback && voidCallback != null) ||
                (!expectingVoidCallback && voidCallback == null),
            "expectingVoidCallback but voidCallback is null"),
         assert(callback is Function?,
         "callback is not a fuction");

  ServiceMessageData getDataObject(int messageId);
}

class ServiceMessageData<T> {
  final int messageId;
  final int serviceId;
  final int taskId;

  final T? data;

  ServiceMessageData(this.data,
      {required this.messageId, required this.serviceId, required this.taskId});
}

class ServiceResponse<T> {
  final int messageId;
  final OperationStatus status;
  final T? data;

  ServiceResponse(
      {required this.messageId, required this.status, required this.data});
}

abstract class Service {
  int get serviceId;
  Future<ServiceResponse> handleMessage(ServiceMessageData message);
}

abstract class ServiceGateway {
  Future<void> forwardMessage(ServiceMessageData message);
  Future<void> registerService(Service service);
}

abstract class TaskDelegate<R, D> {
  int get taskId;

  Future<ServiceResponse<R>> execute();
  Future<void> setTaskData(ServiceMessageData<D> message);
}

class IsolateParameters{
  final SendPort uiThreadPort;
  final String appDocumentsPath;

  IsolateParameters(this.uiThreadPort, this.appDocumentsPath);
}

enum OperationStatus {
  success,
  noData,
  error,
}

enum AppServices {
  localDatabase,
  remoteServer,
}
