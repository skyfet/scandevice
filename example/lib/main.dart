import 'package:flutter/material.dart';
import 'package:scandevice/scandevice.dart';

final scanner = Scandevice();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await scanner.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _scannedCode = 'No scan.';
  // bool _continue = false;

  @override
  void initState() {
    super.initState();
    scanner.listeners.add((message) {
      setState(() {
        _scannedCode = message;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(child: Text('Open'), onPressed: () => scanner.open()),
              ElevatedButton(child: Text('Close'), onPressed: () => scanner.close()),
              ElevatedButton(child: Text('Scan'), onPressed: () => scanner.scan()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Vibrate"),
                  Switch(
                    value: scanner.vibrate,
                    onChanged: (s) => setState(() => scanner.vibrate = s),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Beep"),
                  Switch(
                    value: scanner.beep,
                    onChanged: (s) => setState(() => scanner.beep = s),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text("Continue after scan?"),
              //     Switch(
              //       value: _continue,
              //       onChanged: (s) => setState(() {
              //         s ? scanner.setContinueScanning() : scanner.setOnceScanning();
              //         print('beep: $s');
              //         _continue = s;
              //       }),
              //     ),
              //   ],
              // ),
              // ElevatedButton(child: Text('Reset'), onPressed: () => scanner.reset()),
              Text(_scannedCode),
            ],
          ),
        ),
      ),
    );
  }
}
