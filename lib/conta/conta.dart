import 'package:flutter/material.dart';
import 'numero.dart';
import 'teclado.dart';

class ContaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Scaffold(
    body: new Column(
      children: <Widget>[
        new Numero(),
        new Teclado(),
        new Stack(
          alignment: new FractionalOffset(0.5, 1.0),
          children: <Widget>[
            new FloatingActionButton(
              elevation: 0.0,
              child: new Icon(Icons.check),
              backgroundColor: new Color(0xFFE57373),
              onPressed: (){}
            )
          ],
        )
      ],
    ), 
  );
}