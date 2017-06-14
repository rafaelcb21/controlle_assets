import 'package:flutter/material.dart';

class CardContas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return new Container(
      padding: new EdgeInsets.only(bottom: 6.0, right: 6.0, left: 6.0),
      child: new  Card(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.only(left: 18.0, top: 18.0),
              child: new Text(
              'Contas',
                style: new TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Roboto',
                  color: new Color(0xFF757575),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ), 
            new ListTile(
              leading: new CircleAvatar(
                backgroundImage: new AssetImage('lib/images/itau2.jpg'),
                backgroundColor: new Color(0xFF1A5493),
                radius: 16.0,
              ),
              //leading: new Icon(
              //  Icons.card_giftcard
              //),
              title: new Text(
                'Caixa',
                style: new TextStyle(
                  fontSize: 13.0,
                  fontFamily: 'Roboto',
                  color: new Color(0xFF212121),
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: new Text(
                'Conta corrente',
                style: new TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Roboto',
                  color: new Color(0xFF9E9E9E)
                ),
              ),
              trailing: new Text(
                'R\$ 3.051,00',
                style: new TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Roboto',
                  color: new Color(0xFF26C6DA)
                ),
              )
            ),

            new Container(
              padding: new EdgeInsets.only(left: 74.0),
              child: new Divider(),
            ),

            new ListTile(
              leading: new CircleAvatar(
                //backgroundImage: new AssetImage('lib/images/Caixa_Economica_Federal.svg'),
                backgroundColor: new Color(0xFF26C6DA),
                radius: 16.0,
              ),
              title: new Text(
                'Itau',
                style: new TextStyle(
                  fontSize: 13.0,
                  fontFamily: 'Roboto',
                  color: new Color(0xFF212121),
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: new Text(
                'Conta corrente',
                style: new TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Roboto',
                  color: new Color(0xFF9E9E9E)
                ),
              ),
              trailing: new Text(
                'R\$ 3.051,00',
                style: new TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Roboto',
                  color: new Color(0xFF26C6DA)
                ),
              )
            ),
          ]
        ),
      ),
    );
  }
}