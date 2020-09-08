import 'package:flutter/material.dart';

//Widget imports
import './menu/title_text.dart';
import './menu/menu_button.dart';

import './local_notifications_plugin.dart';

class Menu extends StatelessWidget {
  final Function goToViewing;

  Menu(this.goToViewing);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                  child: TitleText(),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MenuButton('Start Viewing Pressure Generated Map', goToViewing,),
                  MenuButton('Exit', () => print('Exit pressed'),),
                ]
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}