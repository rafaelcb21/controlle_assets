import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'numero.dart';
import 'teclado.dart';
import 'formulario.dart';
import 'dart:ui' as ui;

class ContaPage extends StatefulWidget {
  final Color color;
  ContaPage(this.color);
  ContaPageStatus createState() => new ContaPageStatus(this.color);
}


class ContaPageStatus extends State<ContaPage> {
  ContaPageStatus(this.color);
  final Color color;
  ValueNotifier<List<int>> numeros = new ValueNotifier<List<int>>(<int>[]);

  String numeroBrasil(List<int> numerosLista){
    if(numerosLista.length == 0) {
      return '0,00';
    }
    if(numerosLista.length == 1) {
      return '0,0' + numerosLista[0].toString();
    }
    if(numerosLista.length == 2) {
      return '0,' + numerosLista[0].toString() + numerosLista[1].toString();
    }
    if(numerosLista.length >= 3) {
      List<int> inteiroLista = numerosLista.getRange(0, numerosLista.length -2);
      List<int> decimalLista = numerosLista.getRange(numerosLista.length -2, numerosLista.length);
      String inteiroListaString = inteiroLista.map((i) => i.toString()).join('');
      String decimalListaString = decimalLista.map((i) => i.toString()).join('');

      var f = new NumberFormat("#,###,###,###,###.00", "pt_BR");
      var valor = f.format(double.parse(inteiroListaString + '.' + decimalListaString));
      return  valor;

    }
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
    body: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,       
      children: <Widget>[
        new NumeroDisplay(color, numeros),
        //new Teclado(color, numeros),
        new MyCustomCard(),
        new Flexible(
          child: new Container(
            padding: new EdgeInsets.only(bottom: 16.0),
            child: new FloatingActionButton(
              elevation: 0.0,
              child: new Icon(Icons.check),
              backgroundColor: color,
              onPressed: (){
                Navigator.pop(context);
                Navigator.push(context, new MaterialPageRoute(
                  builder: (BuildContext context) => new FormularioPage(
                    color,
                    numeroBrasil(this.numeros.value)
                  )
                ));
              }
            )
          )         
        )
      ],
    ), 
  );
}

class MyCustomCard extends StatelessWidget {

  Widget build(BuildContext context) {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _width = logicalSize.width;
    final double _height = logicalSize.height;

    return new Container(
      height: _height - 145.0,
      width: _width,
      //decoration: new BoxDecoration(
      //  color: new Color(color),
      //  border: new Border.all(color: new Color(0xFF9E9E9E)),
      //),
      //child: new FlutterLogo(size: 100.0, colors: color),
    );
  }
}