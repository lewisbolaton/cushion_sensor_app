import 'package:flutter/material.dart';

class ViewerBox extends StatelessWidget {
  final double _percentage;

  ViewerBox(this._percentage);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1.5),
          color: generateRGBO(),
        ),
      ),
    );
  }

  Color generateRGBO() {
    return Color.fromRGBO(
        calculateRedValue(),
        calculateGreenValue(),
        0,
        1.0,
    );
  }

  int calculateRedValue() {
    if (this._percentage < 0.0) {
      return 0;
    } else if (this._percentage <= 0.5) {
      return ((this._percentage / 0.5) * 255).toInt();
    } else if (this._percentage <= 1.0) {
      return 255;
    } else {
      return 0;
    }
  }

  int calculateGreenValue() {
    if (this._percentage < 0.0) {
      return 255;
    } else if (this._percentage <= 0.5) {
      return 255;
    } else if (this._percentage <= 1.0) {
      return (((1.0 - this._percentage) / 0.5) * 255).toInt();
    } else {
      return 255;
    }
  }
}