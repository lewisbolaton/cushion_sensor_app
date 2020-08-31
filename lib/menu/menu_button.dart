import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String buttonText;
  final Function clickHandler;

  MenuButton(this.buttonText, this.clickHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: RaisedButton(
        shape: CircleBorder(),
        onPressed: clickHandler,
        child: Text(
          this.buttonText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}