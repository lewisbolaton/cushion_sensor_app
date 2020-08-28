import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './menu/title_text.dart';

class Menu extends StatelessWidget {
  final Function goToViewing;

  Menu(this.goToViewing);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: TitleText(),
              width: double.infinity,
            ),
            RaisedButton(
              child: Text('Start Viewing Pressure Generated Map'),
              onPressed: goToViewing,
            ),
            RaisedButton(
              child: Text('Exit'),
              onPressed: () => SystemNavigator.pop(),
            ),
          ],

        ),
      ),
    );
  }
}