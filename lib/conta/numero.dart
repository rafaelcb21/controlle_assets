import 'package:flutter/material.dart';

class Numero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 145.0,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.only(right: 16.0, top: 35.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text(
                  'R\$  ',
                  style: new TextStyle(
                    fontFamily: 'Roboto',
                    color: new Color(0xFFFFFFFF),
                    fontSize: 20.0
                  )
                ),
                new Text(
                  '0,00',
                  style: new TextStyle(
                    fontFamily: 'Roboto',
                    color: new Color(0xFFFFFFFF),
                    fontSize: 45.0
                  )
                ),
              ],
            )
          )
        ],
      ),
      color: new Color(0xFFE57373),
    );
  }
}