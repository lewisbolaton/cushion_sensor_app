import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/material.dart';

//Third-party package imports
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

//Widget imports
import './menu.dart';
import './viewer.dart';
import './menu/connection_dialog.dart';

const String sensorAddress = 'B8:27:EB:7B:98:0B';

void main() => runApp(CushionSensorApp());

class CushionSensorApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CushionSensorAppState();
}

class _CushionSensorAppState extends State<CushionSensorApp> {
  String _appState;

  //Bluetooth-related variables
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  BluetoothConnection connection;
  int _deviceState;
  bool isDisconnecting = false;

  List<List<double>> sensorValues;

  var navigatorKey = GlobalKey<NavigatorState>();

  bool get isConnected => connection != null && connection.isConnected;

  @override
  void initState() {
    super.initState();

    var rng = Random();
    sensorValues = List.generate(
        15, (_) => List.generate(15, (_) => rng.nextInt(100) / 100));

    _appState = 'idle';
    initializeBTSettings();
  }

  @override
  void dispose() {
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
        backgroundColor: Colors.teal,
      ),
      /*
      home: (_appState == 'idle')
          ? Menu(goToViewing)
          : Viewer(returnToIdle, _connect, sensorValues),
      */
      home: Menu(goToViewing),
    );
  }

  void goToViewing() async {
    //Check if Bluetooth then connect to sensor
    if (_bluetoothState != BluetoothState.STATE_ON) {
      //await _connect();
      BuildContext _context = navigatorKey.currentState.context;
      Navigator.push(
          _context,
          MaterialPageRoute(builder: (_context) => Viewer(returnToIdle, _connect, sensorValues)),
      );
    } else {
      showDialog(
          context: navigatorKey.currentState.overlay.context,
          barrierDismissible: true,
          builder: (_) => ConnectionDialog());
    }
  }

  void returnToIdle() {
    _disconnect();
    Navigator.pop(navigatorKey.currentState.context);
    setState(() {
      _appState = 'idle';
    });
  }

  void initializeBTSettings() {
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    _deviceState = 0;
    enableBluetooth();

    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
      if (_appState == 'viewing' && state != BluetoothState.STATE_ON) {
        connection.close();
        showDialog(
            context: navigatorKey.currentState.overlay.context,
            barrierDismissible: true,
            builder: (_) => ConnectionDialog());
        setState(() {
          _appState = 'idle';
        });
      }
    });
  }

  Future<void> enableBluetooth() async {
    _bluetoothState = await FlutterBluetoothSerial.instance.state;

    if (_bluetoothState == BluetoothState.STATE_OFF) {
      //Notify user to enable Bluetooth
      await FlutterBluetoothSerial.instance.requestEnable();
      return true;
    }

    return false;
  }

  List<List<int>> chunkInts(List<int> list, int size) {
    if (list.length <= size) {
      return [list];
    }
    return [list.sublist(0, size), ...chunkInts(list.sublist(size), size)];
  }

  List<List<double>> chunkDoubles(List<double> list, int size) {
    if (list.length <= size) {
      return [list];
    }
    return [list.sublist(0, size), ...chunkDoubles(list.sublist(size), size)];
  }

  double decodeList(List<int> intBytes) {
    int s = (intBytes[3] >> 7) % 2;
    int m = (intBytes[0] % pow(2, 8)) +
        ((intBytes[1] << 8) % pow(2, 16)) +
        ((intBytes[2] << 16) % pow(2, 23));
    int e = (intBytes[3] % pow(2, 7)) * 2 + ((intBytes[2] >> 7) % 2);

    return (pow(-1, s) * (1 + m * pow(2, -23)) * pow(2, e - 127));
  }

  Future<void> _connect() async {
    if (!isConnected) {
      await BluetoothConnection.toAddress(sensorAddress).then((_connection) {
        setState(() {
          _appState = 'viewing';
        });
        connection = _connection;

        connection.input.listen((Uint8List data) {
          List<double> flatValues = chunkInts(data.toList(), 4)
              .map((bytes) => decodeList(bytes))
              .toList();
          setState(() {
            sensorValues = chunkDoubles(flatValues, 15);
          });
        }).onDone(() {
          showDialog(
              context: navigatorKey.currentState.overlay.context,
              barrierDismissible: true,
              builder: (_) => ConnectionDialog());
          setState(() => _appState = 'idle');
        });
      }).catchError((err) {
        //For debugging
        //print('Cannot connect, exception occurred');
        //print(err);
        showDialog(
            context: navigatorKey.currentState.overlay.context,
            barrierDismissible: true,
            builder: (_) => ConnectionDialog());
      });
    }
  }

  void _disconnect() async {
    await connection.close();
  }
}
