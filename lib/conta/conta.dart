import 'package:flutter/material.dart';
import 'numero.dart';
import 'teclado.dart';

class ContaPage extends StatelessWidget {
  ContaPage(this.color);
  final Color color;

  @override
  Widget build(BuildContext context) => new Scaffold(
    body: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,       
      children: <Widget>[
        new Numero(color),
        new Teclado(color),
        new Flexible(
          child: new Container(
            padding: new EdgeInsets.only(bottom: 16.0),
            child: new FloatingActionButton(
              elevation: 0.0,
              child: new Icon(Icons.check),
              backgroundColor: color,
              onPressed: (){}
            )
          )         
        )
      ],
    ), 
  );
}