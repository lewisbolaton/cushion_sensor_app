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
    return Column(
      children: [...this.widget.sensorValues.map((row) => Container(
        child: Row(
          children: [...row.map((box) => ViewerBox(box))],
        ),
        width: double.infinity,
      ))]
    );
  }
}