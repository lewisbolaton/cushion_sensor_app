import 'package:flutter/material.dart';

import './viewer_box.dart';

class ViewerGrid extends StatefulWidget {
  final List<List<double>> sensorValues;

  ViewerGrid(this.sensorValues);

  @override
  State<StatefulWidget> createState() {
    return _ViewerGridState();
  }
}

class _ViewerGridState extends State<ViewerGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          ...this.widget.sensorValues.map((row) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...row.map((box) => ViewerBox(box)),
            ],
          )),
        ],
      ),
    );
  }
}