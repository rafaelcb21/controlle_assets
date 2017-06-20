import "package:flutter/material.dart";

import "card_saldo.dart";
import "card_contas.dart";
import "card_cartoes.dart";
import "card_alertas.dart";

void main() {
  runApp(new ControlleApp());
}

class ControlleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Controlle Financeiro",
      home: new HomePage(),
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
      tooltip: 'Add',
      child: new Icon(Icons.add),
      backgroundColor: new Color(0xFFF44336),
      onPressed: (){
        new SimpleDialog(
          title: new Text('Teste'),
          children: <Widget>[
            new RadioListTile(
              title: new Text('Testando'), value: null, groupValue: null, onChanged: (value) {},
            )
          ],
        );
      },
    ),
    
  );
}