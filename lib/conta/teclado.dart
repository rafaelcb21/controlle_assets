import 'package:flutter/material.dart';

class Teclado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.only(right: 15.0, left: 15.0, top: 47.0),
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new FlatButton(
                textColor: new Color(0xFFE57373),
                child: new Text(
                  '1',
                  style: new TextStyle(
                    fontSize: 35.0
                  ),
                ),
                onPressed: () {},
              ),
              new FlatButton(
                textColor: new Color(0xFFE57373),
                child: new Text(
                  '2',
                  style: new TextStyle(
                    fontSize: 35.0
                  ),
                ),
                onPressed: () {},
              ),
              new FlatButton(
                textColor: new Color(0xFFE57373),
                child: new Text(
                  '3',
                  style: new TextStyle(
                    fontSize: 35.0
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
          new Container(height: 30.0),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new FlatButton(
                textColor: new Color(0xFFE57373),
                child: new Text(
                  '4',
                  style: new TextStyle(
                    fontSize: 35.0
                  ),
                ),
                onPressed: () {},
              ),
              new FlatButton(
                textColor: new Color(0xFFE57373),
                child: new Text(
                  '5',
                  style: new TextStyle(
                    fontSize: 35.0
                  ),
                ),
                onPressed: () {},
              ),
              new FlatButton(
                textColor: new Color(0xFFE57373),
                child: new Text(
                  '6',
                  style: new TextStyle(
                    fontSize: 35.0
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
          new Container(height: 30.0),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new FlatButton(
                textColor: new Color(0xFFE57373),
                child: new Text(
                  '7',
                  style: new TextStyle(
                    fontSize: 35.0
                  ),
                ),
                onPressed: () {},
              ),
              new FlatButton(
                textColor: new Color(0xFFE57373),
                child: new Text(
                  '8',
                  style: new TextStyle(
                    fontSize: 35.0
                  ),
                ),
                onPressed: () {},
              ),
              new FlatButton(
                textColor: new Color(0xFFE57373),
                child: new Text(
                  '9',
                  style: new TextStyle(
                    fontSize: 35.0
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
          new Container(height: 30.0),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new FlatButton(
                textColor: new Color(0xFFE57373),
                child: new Text(
                  ' ',
                  style: new TextStyle(
                    fontSize: 35.0
                  ),
                ),
                onPressed: () {},
              ),
              new FlatButton(
                textColor: new Color(0xFFE57373),
                child: new Text(
                  '0',
                  style: new TextStyle(
                    fontSize: 35.0
                  ),
                ),
                onPressed: () {},
              ),
              new FlatButton(
                textColor: new Color(0xFFE57373),

                child: new Icon(
                  Icons.backspace,
                  size: 35.0
                ),
                onPressed: () {},
              ),
            ],
          ),
          //new Container(height: 30.0),
          //new Row(
          //  mainAxisAlignment: MainAxisAlignment.center,
          //  children: <Widget>[
          //new Align(
          //  alignment: new FractionalOffset(0.5, 0.5),
          //  child: new FloatingActionButton(
          //    elevation: 0.0,
          //    child: new Icon(Icons.check),
          //    backgroundColor: new Color(0xFFE57373),
          //    onPressed: (){}
          //  )
          //)
              
            //],
          //)
        ],
      ),
    );
  }
}