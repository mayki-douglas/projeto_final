import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre'),
      ),
      body: Column(
        children:[
          Text('Desenvolvido por: Mayki Douglas\nemail: mayki.douglas1@gmail.com', textAlign: TextAlign.center),
          TextButton.icon(
            icon: Icon(Icons.arrow_back),
            label: Text('Voltar para o início'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}