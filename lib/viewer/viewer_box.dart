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
        (_percentage * 255).toInt(),
        ((1 - _percentage) * 255).toInt(),
        0,
        1.0,
    );
  }
}