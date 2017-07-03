import 'package:flutter/material.dart';

class FormularioPage extends StatelessWidget {
  final Color color;
  final String numeros;
  FormularioPage(this.color, this.numeros); 

  @override
  Widget build(BuildContext context) {
    Widget displayNumber = new Container(
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
                  this.numeros,
                  style: new TextStyle(
                    fontFamily: 'Roboto',
                    color: new Color(0xFFFFFFFF),
                    fontSize: 45.0
                  )
                ),
              ],
            )
          )
        ],
      ),
      color: color,
    );

    Widget fields = new Container(
      padding: new EdgeInsets.all(18.0),
      child: new Column(
        children: <Widget>[
          new InkWell(
            //onTap: onPressed,
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
                  new Text('DE', style: Theme.of(context).textTheme.title),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return new Scaffold(
      body: new ListView(        
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,       
            children: <Widget>[
              displayNumber,
              fields,
              new Flexible(
                child: new Container(
                  padding: new EdgeInsets.only(bottom: 16.0),
                  child: new FloatingActionButton(
                    elevation: 0.0,
                    child: new Icon(Icons.check),
                    backgroundColor: color,
                    onPressed: () {}
                  )
                )         
              )
            ],
          ),        
        ],
      ) 
    );
  }
}