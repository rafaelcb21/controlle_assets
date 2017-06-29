import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'numero.dart';
import 'teclado.dart';

class ContaPage extends StatefulWidget {
  final Color color;
  ContaPage(this.color);
  ContaPageStatus createState() => new ContaPageStatus(this.color);
}


class ContaPageStatus extends State<ContaPage> {
  ContaPageStatus(this.color);
  final Color color;
  ValueNotifier<List<int>> numeros = new ValueNotifier<List<int>>(<int>[]);

  @override
  Widget build(BuildContext context) => new Scaffold(
    body: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,       
      children: <Widget>[
        new NumeroDisplay(color, numeros),
        new Teclado(color, numeros),
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