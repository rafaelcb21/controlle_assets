import "package:flutter/material.dart";

import "home/card_saldo.dart";
import "home/card_contas.dart";
import "home/card_cartoes.dart";
import "home/card_alertas.dart";
import "conta/conta.dart";

void main() {
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
        '/conta': (BuildContext context) => new ContaPage()
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Scaffold(
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
    body: new ListView  (
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
    floatingActionButton: new FloatingActionButton(
      child: new Icon(Icons.add),
      backgroundColor: new Color(0xFFE57373),
      onPressed: (){
        showDialog(
          context: context, 
          child: new SimpleDialog(
            children: <Widget>[
              new FlatButton(
                textColor: new Color(0xFF9E9E9E),
                child: new Row(
                  children: <Widget>[
                    new Icon(
                      Icons.add_circle,
                      size: 24.0
                    ),
                    new Container(
                      padding: new EdgeInsets.only(left: 16.0),
                      child: new Text(
                        'transferência',
                        style: new TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16.0
                        ),
                      ),
                    )
                  ],
                ),                
                onPressed: () {},
              ),
              new FlatButton(
                textColor: new Color(0xFF66BB6A),
                child: new Row(
                  children: <Widget>[
                    new Icon(
                      Icons.add_circle,
                      size: 24.0
                    ),
                    new Container(
                      padding: new EdgeInsets.only(left: 16.0),
                      child: new Text(
                        'receita',
                        style: new TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16.0
                        ),
                      ),
                    )
                  ],
                ),                
                onPressed: () {},
              ),
              new FlatButton(
                textColor: new Color(0xFFF44336),
                child: new Row(
                  children: <Widget>[
                    new Icon(
                      Icons.add_circle,
                      size: 24.0
                    ),
                    new Container(
                      padding: new EdgeInsets.only(left: 16.0),
                      child: new Text(
                        'despesa',
                        style: new TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16.0
                        ),
                      ),
                    )
                  ],
                ),                
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/conta');
                  //Navigator.of(context).pop();
                  //Navigator.of(context).pushNamed('/conta');
                },
              ),
            ],
          )
        );
      }     
    ),    
  );
}