import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String buttonText;
  final Function clickHandler;

  MenuButton(this.buttonText, this.clickHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: FlatButton(
        shape: CircleBorder(),
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