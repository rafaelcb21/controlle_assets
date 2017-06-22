import 'package:flutter/material.dart';
import 'numero.dart';

class ContaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Scaffold(
    body: new ListView(
      children: <Widget>[
         new Numero()
      ],
    )
  );
}