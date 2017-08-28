import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'dart:async';
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
                    fontSize: 35.0,
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
 
class Formulario extends StatefulWidget {
  @override
  FormularioState createState() => new FormularioState();
}
 
class FormularioState extends State<Formulario> {
  DateTime _toDate = new DateTime.now();
  String _valueText = "Outros";
  String _valueTextCartao = "Cartão";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
 
  void showDemoDialog<T>({ BuildContext context, Widget child }) {
    showDialog<T>(
      context: context,
      child: child,
    )
    .then<Null>((T value) { // The value passed to Navigator.pop() or null.
      if (value != null) {
        setState(() {
          _valueText = value.toString();
        });
      }
    });
  }
 
  void showDialogCartao<T>({ BuildContext context, Widget child }) {
    showDialog<T>(
      context: context,
      child: child,
    )
    .then<Null>((T value) { // The value passed to Navigator.pop() or null.
      if (value != null) {
        setState(() {
          _valueTextCartao = value.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle valueStyle = Theme.of(context).textTheme.title;
 
    return new Container(
      padding: new EdgeInsets.only(right: 24.0, left: 24.0, top: 0.0, bottom: 0.0),
      child: new Column(
        children: <Widget>[
          new _DateTimePicker(
            labelText: 'Data',
            selectedDate: _toDate,
            selectDate: (DateTime date) {
              setState(() {
                _toDate = date;
             });
            },
          ),
 
          new Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Expanded(
                flex: 4,
                child: new _InputDropdown(
                  labelText: 'Categoria',
                  valueText: _valueText,
                  valueStyle: valueStyle,
                  onPressed: () {
                    showDemoDialog<String>(
                      context: context,
                      child: new SimpleDialog(
                        title: const Text('Categorias'),
                        children: <Widget>[
                          new DialogItem(
                            icon: Icons.brightness_1,
                            color: new Color(0xFFFFA500),
                            text: 'Alimentação',
                            onPressed: () { Navigator.pop(context, 'Alimentação'); }
                          ),
                          new DialogItem(
                            icon: Icons.brightness_1,
                            color: new Color(0xFF279605),
                            text: 'Cartão',
                            onPressed: () { Navigator.pop(context, 'Cartão'); }
                          ),
                          new DialogItem(
                            icon: Icons.brightness_1,
                            color: new Color(0xFF005959),
                            text: 'Educação',                           
                            onPressed: () { Navigator.pop(context, 'Educação'); }
                          ),
                          new DialogItem(
                            icon: Icons.subdirectory_arrow_right,
                            size: 16.0,
                            color: theme.disabledColor,
                            text: 'Cultura',
                            onPressed: () { Navigator.pop(context, 'Cultura'); }
                          ),
                          new DialogItem(
                            icon: Icons.brightness_1,
                            color: new Color(0xFFFF99FF),
                            text: 'Investimento',
                            onPressed: () { Navigator.pop(context, 'Investimento'); }
                          ),
                          new DialogItem(
                            icon: Icons.subdirectory_arrow_right,
                            size: 16.0,
                            color: theme.disabledColor,
                            text: 'Poupança',
                            onPressed: () { Navigator.pop(context, 'Poupança'); }
                          ),
                          new DialogItem(
                            icon: Icons.brightness_1,
                            color: new Color(0xFF00ABFF),
                            text: 'Lazer',
                            onPressed: () { Navigator.pop(context, 'Lazer'); }
                          ),
                          new DialogItem(
                            icon: Icons.brightness_1,
                            color: new Color(0xFFB6A8A5),
                            text: 'Moradia',
                            onPressed: () { Navigator.pop(context, 'Moradia'); }
                          ),
                          new DialogItem(
                            icon: Icons.subdirectory_arrow_right,
                            size: 16.0,
                            color: theme.disabledColor,
                            text: 'Eletrônico',                           
                            onPressed: () { Navigator.pop(context, 'Eletrônico'); }
                          ),
                          new DialogItem(
                            icon: Icons.subdirectory_arrow_right,
                            size: 16.0,
                            color: theme.disabledColor,
                            text: 'Hotel',
                            onPressed: () { Navigator.pop(context, 'Hotel'); }
                          ),
                          new DialogItem(
                            icon: Icons.brightness_1,
                            color: new Color(0xFF000000),
                            text: 'Outros',
                            onPressed: () { Navigator.pop(context, 'Outros'); }
                          ),
                          new DialogItem(
                            icon: Icons.brightness_1,
                            color: new Color(0xFFA3D97D),
                            text: 'Salário',                           
                            onPressed: () { Navigator.pop(context, 'Salário'); }
                          ),
                          new DialogItem(
                            icon: Icons.brightness_1,
                            color: new Color(0xFFF5423C),
                            text: 'Saúde',
                            onPressed: () { Navigator.pop(context, 'Saúde'); }
                          ),
                          new DialogItem(
                            icon: Icons.subdirectory_arrow_right,
                            size: 16.0,
                            color: theme.disabledColor,
                            text: 'Cosméticos',
                            onPressed: () { Navigator.pop(context, 'Cosméticos'); }
                          ),
                          new DialogItem(
                            icon: Icons.subdirectory_arrow_right,
                            size: 16.0,
                            color: theme.disabledColor,
                            text: 'Drogaria',
                            onPressed: () { Navigator.pop(context, 'Drogaria'); }
                          ),
                          new DialogItem(
                            icon: Icons.brightness_1,
                            color: new Color(0xFF92A8D1),
                            text: 'Telefonia',                           
                            onPressed: () { Navigator.pop(context, 'Telefonia'); }
                          ),
                          new DialogItem(
                            icon: Icons.brightness_1,
                            color: new Color(0xFFF6F902),
                            text: 'Transporte',
                            onPressed: () { Navigator.pop(context, 'Transporte'); }
                          ),
                          new DialogItem(
                            icon: Icons.brightness_1,
                            color: new Color(0xFF3DDF0B),
                            text: 'Vestuário',                            
                            onPressed: () { Navigator.pop(context, 'Vestuário'); }
                          )
                        ]
                      )
                    );
                  },
                ),
              ),
            ],
          ),

          new Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Expanded(
                flex: 4,
                child: new _InputDropdown(
                  labelText: 'Conta/Cartão',
                  valueText: _valueTextCartao,
                  valueStyle: valueStyle,
                  onPressed: () {
                    showDialogCartao<String>(
                      context: context,
                      child: new SimpleDialog(
                        title: const Text('Selecione uma conta'),
                        children: <Widget>[
                          new Container(
                            padding: new EdgeInsets.only(left: 24.0, top: 8.0, bottom: 8.0),
                            color: new Color(0xFFDFD9D9),
                            child: new Text('CONTAS'),
                          ),                          
                          new DialogItem(
                            icon: Icons.brightness_1,
                            color: new Color(0xFF279605),
                            text: 'Caixa',
                            onPressed: () { Navigator.pop(context, 'Caixa'); }
                          ),
                          new Container(
                            padding: new EdgeInsets.only(left: 24.0, top: 8.0, bottom: 8.0),
                            color: new Color(0xFFDFD9D9),
                            child: new Text('CARTÕES'),
                          ),
                          new DialogItem(
                            icon: Icons.brightness_1,
                            color: new Color(0xFF005959),
                            text: 'NuBank',                           
                            onPressed: () { Navigator.pop(context, 'NuBank'); }
                          ),
                        ],
                      )
                    );
                  }
                )
              )
            ],
          ),
        ]
      )
    );
  }
}
 
class DialogItem extends StatelessWidget {
  DialogItem({ Key key, this.icon, this.size, this.color, this.text, this.onPressed }) : super(key: key);
 
  final IconData icon;
  double size = 36.0;
  final Color color;
  final String text;
  final VoidCallback onPressed;
 
  @override
  Widget build(BuildContext context) {
    return new SimpleDialogOption(
      onPressed: onPressed,
      child: new Container(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(              
              child: new Container(
                margin: size == 16.0 ? new EdgeInsets.only(left: 7.0) : null,
                child: new Icon(icon, size: size, color: color),
              )                
            ),        
            new Padding(
              padding: size == 16.0 ? const EdgeInsets.only(left: 17.0) : const EdgeInsets.only(left: 16.0),
              child: new Text(text),
            ),
          ],
        ),
      )
    );
  }
}
 
class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker({
    Key key,
    this.labelText,
    this.selectedDate,
    this.selectDate,
  }) : super(key: key);
 
  final String labelText;
  final DateTime selectedDate;
  final ValueChanged<DateTime> selectDate;
 
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: new DateTime(2015, 8),
      lastDate: new DateTime(2101)
    );
    if (picked != null && picked != selectedDate)
      selectDate(picked);
  }
 
  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.title;
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Expanded(
          flex: 4,
          child: new _InputDropdown(
            labelText: labelText,
            valueText: new DateFormat.yMd().format(selectedDate),
            valueStyle: valueStyle,
            onPressed: () { _selectDate(context); },
          ),
       ),
      ],
    );
  }
}
 
class _InputDropdown extends StatelessWidget {
  const _InputDropdown({
    Key key,
    this.child,
    this.labelText,
    this.valueText,
    this.valueStyle,
    this.onPressed }) : super(key: key);
 
  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;
 
  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child: new InputDecorator(
        decoration: new InputDecoration(
          labelText: labelText,
          isDense: true,
        ),
        baseStyle: valueStyle,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(valueText, style: valueStyle),
          ],
        ),
      ),
    );
  }
}