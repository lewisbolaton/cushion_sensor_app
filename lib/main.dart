import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/material.dart';

//Third-party package imports
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

//Widget imports
import './menu.dart';
import './viewer.dart';

const String sensorAddress = 'B8:27:EB:7B:98:0B';

void main() {
  runApp(CushionSensorApp());
}

class CushionSensorApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CushionSensorAppState();
  }
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

  bool get isConnected => connection != null && connection.isConnected;

  @override
  void initState() {
    super.initState();

    var rng = Random();
    sensorValues = List.generate(15, (_) => List.generate(15, (_) => rng.nextInt(100)/100));

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
      theme: ThemeData(
        backgroundColor: Colors.teal,
      ),
      home: (_appState == 'idle') ? Menu(goToViewing) : Viewer(returnToIdle, _connect, sensorValues),
    );
  }

  void goToViewing() {
    _connect();
    if (isConnected) {
      setState(() {
        _appState = 'viewing';
      });
    } else {
      print('Cannot view map. Connect device first');
    }
  }

  void returnToIdle() {
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

    FlutterBluetoothSerial.instance.onStateChanged().listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
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
    if(list.length <= size){
      return [list];
    }
    return [list.sublist(0, size), ...chunkInts(list.sublist(size), size)];
  }

  List<List<double>> chunkDoubles(List<double> list, int size) {
    if(list.length <= size){
      return [list];
    }
    return [list.sublist(0, size), ...chunkDoubles(list.sublist(size), size)];
  }
  
  double decodeList(List<int> intBytes) {
    int s = (intBytes[3] >> 7) % 2;
    int m = (intBytes[0] % pow(2, 8)) + ((intBytes[1] << 8) % pow(2, 16)) +
        ((intBytes[2] << 16) % pow(2,23));
    int e = (intBytes[3] % pow(2, 7)) * 2 + ((intBytes[2] >> 7) % 2);

    return(pow(-1, s) * ( 1 + m * pow (2, -23)) * pow(2, e - 127));
  }

  void _connect() async {
    if (!isConnected) {
      await BluetoothConnection.toAddress(sensorAddress).then(( _connection) {
        print('Connected to the sensor');
        connection = _connection;

        connection.input.listen((Uint8List data) {
          List<double> flatValues = chunkInts(data.toList(), 4).map((bytes) => decodeList(bytes)).toList();
          setState(() {
            sensorValues = chunkDoubles(flatValues, 15);
          });
        });
      }).catchError((err) {
        print('Cannot connect, exception occurred');
        print(err);
        setState(() {
          _appState = 'idle';
        });
      });
      //show('Device connected');
    }
  }

  void _disconnect() async {
    await connection.close();
  }
}
