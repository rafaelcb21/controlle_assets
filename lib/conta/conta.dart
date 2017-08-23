import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class ContaPage extends StatefulWidget {
  final Color color;
  ContaPage(this.color);
  ContaPageStatus createState() => new ContaPageStatus(this.color);
}


class ContaPageStatus extends State<ContaPage> with TickerProviderStateMixin{
  ContaPageStatus(this.color);
  final Color color;
  ValueNotifier<List<int>> numeros = new ValueNotifier<List<int>>(<int>[]);

  AnimationController _controller;
  Animation _animation;
  Animation<double> _frontScale;
  Animation<double> _backScale;

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
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );

    _animation = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.0, 1.0, curve: Curves.linear),
    );

    _frontScale = new Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.0, 0.5, curve: Curves.easeIn),
    ));
    _backScale = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.5, 1.0, curve: Curves.easeOut),
    );

    _controller.forward();
    super.initState();
  }

  void action() {
    setState((){
        _controller.reverse();
    });    
  }

  void back() {
    setState((){
        _controller.forward();

    });    
  }
  
  @override
  Widget build(BuildContext context) {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _width = logicalSize.width;

    return new Scaffold( 
      body: new Stack(
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new GestureDetector(
                onTap: back,
                child: new NumberDisplay(color, numeros),
              ),          

              new Stack(
                children: <Widget>[
                  new AnimatedBuilder(
                    animation: _backScale,
                    child: new Teclado(color, numeros),
                    builder: (BuildContext context, Widget child) {
                      final Matrix4 transform = new Matrix4.identity()
                        ..scale(1.0, _backScale.value, 1.0);
                      return new Transform(
                        transform: transform,
                        alignment: FractionalOffset.center,
                        child: child,
                      );
                    },
                  ),
                  new AnimatedBuilder(
                    animation: _frontScale,
                    child: new Formulario(),
                    builder: (BuildContext context, Widget child) {
                      final Matrix4 transform = new Matrix4.identity()
                        ..scale(1.0, _frontScale.value, 1.0);
                      return new Transform(
                        transform: transform,
                        alignment: FractionalOffset.center,
                        child: child,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          new Positioned(
            bottom: 16.0,
            left: (_width / 2) - 28,
            child: new ScaleTransition(
              scale: _animation,
              child: new FloatingActionButton(
                backgroundColor: color,
                child: new Icon(Icons.check),
                onPressed: (){
                  action();
                }
              ),
            ),
          )
        ]
      ),
    );
  } 
}

class NumberDisplay extends AnimatedWidget {
  NumberDisplay(this.color, this.numbers) : super(listenable: numbers);

  final ValueNotifier<List<int>> numbers;
  final Color color;

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
    if(numerosLista.length == 3 && numerosLista[0] == 0){
      return '0,' + numerosLista[1].toString() + numerosLista[2].toString();
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
                  numeroBrasil(this.numbers.value),
                  style: new TextStyle(
                    fontFamily: 'Roboto',
                    color: new Color(0xFFFFFFFF),
                    fontSize: 45.0
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      color: color,
    );
  }
}

class Teclado extends StatelessWidget {
  Teclado(this.color, this.numeros);
  final Color color;
  final ValueNotifier<List<int>> numeros;

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.only(right: 15.0, left: 15.0, top: 32.0, bottom: 0.0),
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new FlatButton(
                textColor: color,
                child: new Text(
                  '1',
                  style: new TextStyle(
                    fontSize: 35.0
                  ),
                ),
                onPressed: () {
                  numeros.value = new List.from(numeros.value)..add(1);
                },
              ),
              new FlatButton(
                textColor: color,
                child: new Text(
                  '2',
                  style: new TextStyle(
                    fontSize: 35.0
                  ),
                ),
                onPressed: () {
                  numeros.value = new List.from(numeros.value)..add(2);
                },
              ),
              new FlatButton(
                textColor: color,
                child: new Text(
                  '3',
                  style: new TextStyle(
                    fontSize: 35.0
                  ),
                ),
                onPressed: () {
                  numeros.value = new List.from(numeros.value)..add(3);
                },
              ),
            ],
          ),
          new Container(height: 30.0),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new FlatButton(
                textColor: color,
                child: new Text(
                  '4',
                  style: new TextStyle(
                    fontSize: 35.0
                  ),
                ),
                onPressed: () {
                  numeros.value = new List.from(numeros.value)..add(4);
                },
              ),
              new FlatButton(
                textColor: color,
                child: new Text(
                  '5',
                  style: new TextStyle(
                    fontSize: 35.0
                  ),
                ),
                onPressed: () {
                  numeros.value = new List.from(numeros.value)..add(5);
                },
              ),
              new FlatButton(
                textColor: color,
                child: new Text(
                  '6',
                  style: new TextStyle(
                    fontSize: 35.0
                  ),
                ),
                onPressed: () {
                  numeros.value = new List.from(numeros.value)..add(6);
                },
              ),
            ],
          ),
          new Container(height: 30.0),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new FlatButton(
                textColor: color,
                child: new Text(
                  '7',
                  style: new TextStyle(
                    fontSize: 35.0
                  ),
                ),
                onPressed: () {
                  numeros.value = new List.from(numeros.value)..add(7);
                },
              ),
              new FlatButton(
                textColor: color,
                child: new Text(
                  '8',
                  style: new TextStyle(
                    fontSize: 35.0
                  ),
                ),
                onPressed: () {
                  numeros.value = new List.from(numeros.value)..add(8);
                },
              ),
              new FlatButton(
                textColor: color,
                child: new Text(
                  '9',
                  style: new TextStyle(
                    fontSize: 35.0
                  ),
                ),
                onPressed: () {
                  numeros.value = new List.from(numeros.value)..add(9);
                },
              ),
            ],
          ),
          new Container(height: 30.0),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new FlatButton(
                textColor: color,
                child: new Text(
                  ' ',
                  style: new TextStyle(
                    fontSize: 35.0
                  ),
                ),
                onPressed: () {},
              ),
              new FlatButton(
                textColor: color,
                child: new Text(
                  '0',
                  style: new TextStyle(
                    fontSize: 35.0
                  ),
                ),
                onPressed: () {
                  numeros.value = new List.from(numeros.value)..add(0);
                },
              ),
              new FlatButton(
                textColor: color,

                child: new Icon(
                  Icons.backspace,
                  size: 35.0
                ),
                onPressed: () {
                  numeros.value = new List.from(numeros.value)..removeLast();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Formulario extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.only(right: 15.0, left: 15.0, top: 32.0, bottom: 0.0),
      child: new Column(
        children: <Widget>[
          new InkWell(
            onTap: (){
              showDatePicker(
                context: context,
                initialDate: new DateTime.now(),
                firstDate: new DateTime(2000, 1),
                lastDate: new DateTime(2101),
              );
            },
            child: new InputDecorator(
              decoration: new InputDecoration(
                labelText: 'Data',
              ),
              baseStyle: new TextStyle(
                fontSize: 12.0,
                fontFamily: 'Roboto',
                color: new Color(0xFF9E9E9E)
              ),
              
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(new DateTime.now().toIso8601String(), style: Theme.of(context).textTheme.title),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//class Formulario extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    new FloatingActionButton(
//      child: new Icon(Icons.check),
//      onPressed: (){
//        showDatePicker(
//          context: context,
//          initialDate: new DateTime.now(),
//          firstDate: new DateTime(2000, 1),
//          lastDate: new DateTime(2101),
//        );
//      },
//    );
//  }
//}