import "package:flutter/material.dart";

import "home/card_saldo.dart";
import "home/card_contas.dart";
import "home/card_cartoes.dart";
import "home/card_alertas.dart";
import "conta/conta.dart";
import 'package:flutter/animation.dart';
import 'dart:ui' as ui;
import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

//final googleSignIn = new GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

void main() {
  Intl.defaultLocale = 'pt_BR';
  initializeDateFormatting('pt_BR');
  runApp(new ControlleApp());
}

class ControlleApp extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Controlle Financeiro",
      home: new HomePage(),
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => new HomePage(),
        //'/conta': (BuildContext context) => new ContaPage()
      },
    );
  }
}



class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _angle = 90;
  bool _isRotated = true;

  AnimationController _controller;
  Animation<double> _animation;
  Animation<double> _animation2;
  Animation<double> _animation3;

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

    _animation2 = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.5, 1.0, curve: Curves.linear),
    );

    _animation3 = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.8, 1.0, curve: Curves.linear),
    );
    _controller.reverse();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _width = logicalSize.width;
    final double _height = logicalSize.height;

    void _rotate(){
      setState((){
        if(_isRotated) {
          _angle = 45;
          _isRotated = false;
          _controller.forward(from: 0.0);
        } else {
          _angle = 90;
          _isRotated = true;
          _controller.reverse(from: 1.0);
        }
      });
    }

  return new Scaffold( 
    appBar: new AppBar(
      backgroundColor: new Color(0xFF26C6DA),
    ),
    drawer: new Drawer(
      child: new ListView(
        children: <Widget>[
          new DrawerHeader(child: new Text('Header')),
          new ListTile(
            title: new Text('First Menu Item'),
            onTap: () {},
          ),
          new ListTile(
            title: new Text('Second Menu Item'),
            onTap: () {},
          ),
          new Divider(),
          new ListTile(
            title: new Text('About'),
            onTap: () {},
          )
        ],
      ),
    ),
    body: new Stack(
      children: <Widget>[
        new ListView  (
          children: <Widget>[
            new CardSaldo(),
            new CardContas(),
            new CardCartoes(),
            new CardAlertas(),
            new Container(
              height: 70.0,
            )
          ],
        ),
        new Positioned(
            bottom: 0.0,
            child: new GestureDetector(
              onTap: _rotate,
              child: new AnimatedBuilder(
                animation: _animation,
                builder: (BuildContext context, Widget child) {
                  return new Container(
                    height: _height,
                    child: new CustomPaint(
                      painter: new Sky(_width, _height * _animation.value),
                      child: new Container(
                        height: _isRotated ? 0.0 : _height * _animation.value,
                        width: _isRotated ? 0.0 : _width,
                      ),
                    ),
                  );
                }
              ),
            )
          ),
          new Positioned(
            bottom: 200.0,
            right: 24.0,
            child: new Container(
              child: new Row(
                children: <Widget>[
                  new ScaleTransition(
                    scale: _animation3,
                    alignment: FractionalOffset.center,
                    child: new Container(
                      margin: new EdgeInsets.only(right: 16.0),
                      child: new Text(
                        'transferência',
                        style: new TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'Roboto',
                          color: new Color(0xFF9E9E9E),
                          fontWeight: FontWeight.bold,
                        ),
                      ), 
                    ),
                  ),
                  
                  new ScaleTransition(
                    scale: _animation3,
                    alignment: FractionalOffset.center,
                    child: new Material(
                      color: new Color(0xFF9E9E9E),
                      type: MaterialType.circle,
                      elevation: 6.0,
                      child: new GestureDetector(
                        child: new Container(
                          width: 40.0,
                          height: 40.0,
                          child: new InkWell(
                            onTap: (){
                              if(_angle == 45.0){
                                _rotate();
                                //new Future.delayed(const Duration(seconds: 2), () => "2");
                                //sleep(const Duration(seconds:5));
                                //Navigator.pop(context);
                                //Navigator.push(context, new MaterialPageRoute(
                                //  builder: (BuildContext context) => new ContaPage(new Color(0xFF9E9E9E)),
                                //));

                                Navigator.of(context).push(new PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (BuildContext context, _, __) {
                                    return new ContaPage(new Color(0xFF9E9E9E));
                                  },
                                  transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                                    return new FadeTransition(
                                      opacity: animation,
                                      child: child,
                                      //child: new RotationTransition(
                                      //  turns: new Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                                      //  child: child,
                                      //),
                                    );
                                  }
                                ));

                              }
                            },
                            child: new Center(
                              child: new Icon(
                                Icons.add,
                                color: new Color(0xFFFFFFFF),
                              ),                      
                            ),
                          )
                        ),
                      )
                    ),
                  ),                                     
                ],
              ),
            )
          ),
          
          new Positioned(
            bottom: 144.0,
            right: 24.0,
            child: new Container(
              child: new Row(
                children: <Widget>[
                  new ScaleTransition(
                    scale: _animation2,
                    alignment: FractionalOffset.center,
                    child: new Container(
                      margin: new EdgeInsets.only(right: 16.0),
                      child: new Text(
                        'receita',
                        style: new TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'Roboto',
                          color: new Color(0xFF9E9E9E),
                          fontWeight: FontWeight.bold,
                        ),
                      ), 
                    ),
                  ),

                  new ScaleTransition(
                    scale: _animation2,
                    alignment: FractionalOffset.center,
                    child: new Material(
                      color: new Color(0xFF00BFA5),
                      type: MaterialType.circle,
                      elevation: 6.0,
                      child: new GestureDetector(
                        child: new Container(
                          width: 40.0,
                          height: 40.0,
                          child: new InkWell(
                            onTap: (){
                              if(_angle == 45.0){
                                _rotate();
                                //new Future.delayed(const Duration(seconds: 2), () => "2");
                                //sleep(const Duration(seconds:5));
                                //Navigator.pop(context);
                                //Navigator.push(context, new MaterialPageRoute(
                                //  builder: (BuildContext context) => new ContaPage(new Color(0xFF00BFA5)),
                                //));

                                Navigator.of(context).push(new PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (BuildContext context, _, __) {
                                    return new ContaPage(new Color(0xFF00BFA5));
                                  },
                                  transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                                    return new FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  }
                                ));
                              }
                            },
                            child: new Center(
                              child: new Icon(
                                Icons.add,
                                color: new Color(0xFFFFFFFF),
                              ),                      
                            ),
                          )
                        ),
                      )
                    ),
                  ), 
                ],
              ),
            )
          ),
          new Positioned(
            bottom: 88.0,
            right: 24.0,
            child: new Container(
              child: new Row(
                children: <Widget>[
                  new ScaleTransition(
                    scale: _animation,
                    alignment: FractionalOffset.center,
                    child: new Container(
                      margin: new EdgeInsets.only(right: 16.0),
                      child: new Text(
                        'despesa',
                        style: new TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'Roboto',
                          color: new Color(0xFF9E9E9E),
                          fontWeight: FontWeight.bold,
                        ),
                      ), 
                    ),
                  ),
                  
                  new ScaleTransition(
                    scale: _animation,
                    alignment: FractionalOffset.center,
                    child: new Material(
                      color: new Color(0xFFE57373),
                      type: MaterialType.circle,
                      elevation: 6.0,
                      child: new GestureDetector(
                        child: new Container(
                          width: 40.0,
                          height: 40.0,
                          child: new InkWell(
                            onTap: (){
                              if(_angle == 45.0){
                                _rotate();
                                //new Future.delayed(const Duration(seconds: 2), () => "2");
                                //sleep(const Duration(seconds:5));
                                //Navigator.pop(context);
                                //Navigator.push(context, new MaterialPageRoute(
                                //  builder: (BuildContext context) => new ContaPage(new Color(0xFFE57373)),
                                //));
                                Navigator.of(context).push(new PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (BuildContext context, _, __) {
                                    return new ContaPage(new Color(0xFFE57373));
                                  },
                                  transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                                    return new FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  }
                                ));
                              }
                            },
                            child: new Center(
                              child: new Icon(
                                Icons.add,
                                color: new Color(0xFFFFFFFF),
                              ),                      
                            ),
                          )
                      ),
                    )
                    ),
                  ), 
                ],
              ),
            )
          ),
          
          new Positioned(
            bottom: 16.0,
            right: 16.0,
            child: new Material(
              color: new Color(0xFFE57373),
              type: MaterialType.circle,
              elevation: 6.0,
              child: new GestureDetector(
                child: new Container(
                  width: 56.0,
                  height: 56.00,
                  child: new InkWell(
                    onTap: _rotate,
                    child: new Center(
                      child: new RotationTransition(
                        turns: new AlwaysStoppedAnimation(_angle / 360),
                        child: new Icon(
                          Icons.add,
                          color: new Color(0xFFFFFFFF),
                        ),
                      )
                    ),
                  )
                ),
              )
            ),
          ),
      ]
    )
    
    
    //floatingActionButton: new FloatingActionButton(
    //  child: new Icon(Icons.add),
    //  backgroundColor: new Color(0xFFE57373),
    //  onPressed: (){
    //    showDialog(
    //      context: context, 
    //      child: new SimpleDialog(
    //        children: <Widget>[
    //          new FlatButton(
    //            textColor: new Color(0xFF9E9E9E),
    //            child: new Row(
    //              children: <Widget>[
    //                new Icon(
    //                  Icons.add_circle,
    //                  size: 24.0
    //                ),
    //                new Container(
    //                  padding: new EdgeInsets.only(left: 16.0),
    //                  child: new Text(
    //                    'transferência',
    //                    style: new TextStyle(
    //                      fontFamily: 'Roboto',
    //                      fontSize: 16.0
    //                    ),
    //                  ),
    //                )
    //              ],
    //            ),                
    //            onPressed: () {
    //              Navigator.pop(context);
    //              Navigator.push(context, new MaterialPageRoute(
    //                builder: (BuildContext context) => new ContaPage(new Color(0xFF9E9E9E)),
    //              ));
    //            },
    //          ),
    //          new FlatButton(
    //            textColor: new Color(0xFF00BFA5),
    //            child: new Row(
    //              children: <Widget>[
    //                new Icon(
    //                  Icons.add_circle,
    //                  size: 24.0
    //                ),
    //                new Container(
    //                  padding: new EdgeInsets.only(left: 16.0),
    //                  child: new Text(
    //                    'receita',
    //                    style: new TextStyle(
    //                      fontFamily: 'Roboto',
    //                      fontSize: 16.0
    //                    ),
    //                  ),
    //                )
    //              ],
    //            ),                
    //            onPressed: () {
    //              Navigator.pop(context);
    //              Navigator.push(context, new MaterialPageRoute(
    //                builder: (BuildContext context) => new ContaPage(new Color(0xFF00BFA5)),//0xFF00D39D
    //              ));
    //            },
    //          ),
    //          new FlatButton(
    //            textColor: new Color(0xFFE57373),
    //            child: new Row(
    //              children: <Widget>[
    //                new Icon(
    //                  Icons.add_circle,
    //                  size: 24.0
    //                ),
    //                new Container(
    //                  padding: new EdgeInsets.only(left: 16.0),
    //                  child: new Text(
    //                    'despesa',
    //                    style: new TextStyle(
    //                      fontFamily: 'Roboto',
    //                      fontSize: 16.0
    //                    ),
    //                  ),
    //                )
    //              ],
    //            ),                
    //            //onPressed: () {
    //            //  Navigator.popAndPushNamed(context, '/conta');
    //            //},
    //            onPressed: () {
    //              Navigator.pop(context);
    //              Navigator.push(context, new MaterialPageRoute(
    //                builder: (BuildContext context) => new ContaPage(new Color(0xFFE57373)),
    //              ));
    //            },
    //          ),
    //        ],
    //      )
    //    );
    //  }     
    //),    
  );
}
}

class Sky extends CustomPainter {
  final double _width;
  double _rectHeight;

  Sky(this._width, this._rectHeight);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      new Rect.fromLTRB(
        0.0, size.height - _rectHeight, this._width, size.height
      ),
      new Paint()..color = new Color.fromRGBO(255, 255, 255, 0.9)//(0xFF0099FF),(0, 153, 255, 0.5)
    );
  }

  @override
  bool shouldRepaint(Sky oldDelegate) {
    return _width != oldDelegate._width || _rectHeight != oldDelegate._rectHeight;
  }
}