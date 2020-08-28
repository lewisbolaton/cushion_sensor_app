import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: Container(
        child: Text(
            'Pressure Viewing Map',
            style: TextStyle(
              fontSize: 32,
              color: Colors.black45,
            )),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 4, color: Colors.black45),
            bottom: BorderSide(width: 4, color: Colors.black45),
          ),
        ),
      ),
    );
  }
}