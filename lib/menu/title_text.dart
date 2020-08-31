import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return(Container(
        child: Text(
            'Pressure\nViewing Map',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              color: Colors.black,
            )),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 3, color: Colors.black),
            bottom: BorderSide(width: 3, color: Colors.black),
          ),
        ),
      ));
  }
}