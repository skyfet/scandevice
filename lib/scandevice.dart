import 'package:flutter/services.dart';

class Scandevice {
  Scandevice();
  Future init() async {
    try {
      _eventChannel
          .receiveBroadcastStream()
          .forEach((v) => listeners.forEach((listener) => listener(v)));
      connected = true;
    } catch (e) {
      print('SCANDEVICE CONNECTION ERROR: $e');
      connected = false;
    }

    open();

    _beep = await invk<bool>('beep') ?? false;
    _vibrate = await invk<bool>('vibrate') ?? false;
  }

  late bool _beep;
  late bool _vibrate;
  bool connected = false;

  set beep(bool v) => invk((_beep = v) ? 'beepOn' : 'beepOff');
  set vibrate(bool v) => invk((_vibrate = v) ? 'vibrateOn' : 'vibrateOff');

  bool get beep => _beep;
  bool get vibrate => _vibrate;

  void open() => invk('open');
  void scan() => invk('scan');
  void setContinueScanning() => invk('continueScanning');
  void setOnceScanning() => invk('onceScanning');
  void close() => invk('close');
  void reset() => invk('reset');

  static const _eventChannel = const EventChannel('scandevice.events');
  static const _methodChannel = const MethodChannel('scandevice.methods');

  // Выполнить удалённый метод сканнера
  Future<T?> invk<T>(String method) {
    try {
      return _methodChannel.invokeMethod<T>(method);
    } catch (e) {
      print('SCANDEVICE INVOKE ERROR: $e');
      return Future.value();
    }
  }

  final listeners = <Listener>[];
}

typedef void Listener(dynamic message);
