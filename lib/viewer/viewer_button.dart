import 'package:flutter/material.dart';

class ViewerButton extends StatelessWidget {
  final String buttonText;
  final Function clickHandler;

  ViewerButton(this.buttonText, this.clickHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: FlatButton(
        shape: StadiumBorder(),
        color: Colors.white,
        onPressed: clickHandler,
        child: Text(
          this.buttonText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}