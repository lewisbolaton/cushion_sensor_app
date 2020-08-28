import 'package:flutter/material.dart';

//Import widgets
import './viewer/viewer_grid.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            ViewerGrid(this.widget.sensorValues),
            MaterialButton(
              child: Text('Back'),
              onPressed: this.widget.returnToIdle,
            ),
            MaterialButton(
              child: Text('Exit'),
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }
}