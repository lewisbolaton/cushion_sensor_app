import 'package:flutter/material.dart';

//Widget imports
import './menu/title_text.dart';
import './menu/menu_button.dart';
import './menu/connection_dialog.dart';

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
                  MenuButton('Start Viewing Pressure Generated Map', goToViewing),
                  MenuButton('Exit', () => {
                    showDialog(context: context, barrierDismissible: true, builder: (_) => ConnectionDialog()),
                  }),
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