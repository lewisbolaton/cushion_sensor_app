import 'package:cushion_sensor_app/viewer/viewer_button.dart';
import 'package:flutter/material.dart';

//Import widgets
import './viewer/viewer_grid.dart';
import './viewer/viewer_button.dart';

class Viewer extends StatefulWidget {
  final Function returnToIdle;
  final Function connect;
  final List<List<double>> sensorValues;

  Viewer(this.returnToIdle, this.connect, this.sensorValues);

  @override
  State<StatefulWidget> createState() {
    return _ViewerState();
  }
}

class _ViewerState extends State<Viewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
              'Pressure Map',
              style: TextStyle(color: Colors.black,),
            ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ViewerGrid(this.widget.sensorValues),
            ViewerButton('Back', this.widget.returnToIdle),
            ViewerButton('Exit', null),
          ],
        ),
      ),
    );
  }
}