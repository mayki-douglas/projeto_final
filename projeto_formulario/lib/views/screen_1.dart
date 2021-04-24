import 'package:flutter/material.dart';

class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Código Alfa'),),
      body: Column(
        children: [
          Image.asset('images/codigo_alfa.png'),
          Text('Código de identificação do Pneu sempre fica ao lado do DOT', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
          Text('Exemplo: DOT XE X008 1021\nIP: 28008', style: TextStyle(fontSize: 15.0),),
        ],
      ),
    );
  }
}
