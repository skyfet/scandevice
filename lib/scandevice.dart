import 'package:flutter/services.dart';

class Scandevice {
  Scandevice();
  Future init() async {
    _eventChannel
        .receiveBroadcastStream()
        .forEach((v) => listeners.forEach((listener) => listener(v)));

    open();

    _beep = await invk("beep");
    _vibrate = await invk("vibrate");
  }

  bool _beep;
  bool _vibrate;

  set beep(bool v) => invk((_beep = v) ? "beepOn" : "beepOff");
  set vibrate(bool v) => invk((_vibrate = v) ? "vibrateOn" : "vibrateOff");

  bool get beep => _beep;
  bool get vibrate => _vibrate;

  void open() => invk('open');
  void scan() => invk('scan');
  void setContinueScanning() => invk("continueScanning");
  void setOnceScanning() => invk("onceScanning");
  void close() => invk('close');
  void reset() => invk("reset");

  static const _eventChannel = const EventChannel('scandevice.events');
  static const _methodChannel = const MethodChannel('scandevice.methods');

  // Выполнить удалённый метод сканнера
  Future<T> invk<T>(String method) => _methodChannel.invokeMethod<T>(method);
  final listeners = <Listener>[];
}

typedef void Listener(dynamic message);
