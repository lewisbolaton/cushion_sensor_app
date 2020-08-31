import 'package:flutter/material.dart';

class ViewerButton extends StatelessWidget {
  final String buttonText;
  //final Function clickHandler;

  ViewerButton(this.buttonText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: RaisedButton(
        shape: StadiumBorder(),
        elevation: 0,
        color: Colors.white,
        onPressed: () => print('Viewer button pressed'),
        child: Text(
          this.buttonText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}