import "package:flutter/material.dart";

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
      body: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.only(top: 16.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[     
                  new Text(
                    'R\$  ',
                    style: new TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Roboto',
                      color: new Color(0xFF26C6DA),
                    )
                  ),               
                  new Text(
                    '3.435,23',
                    style: new TextStyle(
                      fontSize: 35.0,
                      fontFamily: 'Roboto',
                      color: new Color(0xFF26C6DA)
                    ),
                  )
                ],
              ),
            ),            
            new Text(
              'saldo geral',
              style: new TextStyle(
                fontSize: 12.0,
                fontFamily: 'Roboto',
                color: new Color(0xFF757575),
              ),
            ),
            new Divider(),
            new Text(
              '20/05 - 19/06',
                style: new TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Roboto',
                  color: new Color(0xFF212121),
                ),
              ),
            new Container(
              padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 8.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    'Receita:',
                    style: new TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'Roboto',
                      color: new Color(0xFF757575),
                    ),
                  ),
                  new Text(
                    'R\$ 3.051,00',
                    style: new TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'Roboto',
                      color: new Color(0xFF66BB6A),
                    ),                    
                  )
                ],
              ),
            ),
            new Container(
              padding: const EdgeInsets.only(left: 32.0, right: 32.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    'Despesa:',
                    style: new TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'Roboto',
                      color: new Color(0xFF757575),
                    ),                 
                  ),
                  new Text(
                    'R\$ 2.587,00',
                    style: new TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'Roboto',
                      color: new Color(0xFFF44336),
                    ),                    
                  )
                ],
              ),
            ),            
            new Container(
              padding: const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 16.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    'Resultado:',
                    style: new TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'Roboto',
                      color: new Color(0xFF757575),
                    ),                  
                  ),
                  new Text(
                    'R\$ 464,00',
                    style: new TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'Roboto',
                      color: new Color(0xFF66BB6A),
                    ),                  
                  )
                ],
              ),
            ),            
          ],
        ),
      ),
    );
}