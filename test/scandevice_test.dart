import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:scandevice/scandevice.dart';

void main() {
  const MethodChannel channel = MethodChannel('scandevice');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    // expect(await Scandevice.platformVersion, '42');
  });
}
